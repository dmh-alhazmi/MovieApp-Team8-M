import Foundation
import SwiftUI
import Combine

@MainActor
final class ProfileNetworkViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let api = UsersAPI()

    // profileImageURL: if nil, we will preserve existing attachments; if non-nil, we will replace with a single attachment [{url: profileImageURL}]
    func updateProfile(name: String, profileImageURL: String?, using profile: ProfileModel) async {
        guard !profile.recordID.isEmpty else {
            self.errorMessage = "Missing user record ID."
            return
        }

        isLoading = true
        errorMessage = nil

        do {
            // 1) GET current record
            let current = try await api.getUser(recordID: profile.recordID)

            // 2) Merge: keep all existing fields, override name and profile_image
            // Your existing UserFields definition:
            // struct UserFields { name, password, email, profileImage (string) }
            var mergedFields = current.fields

            // Update name (you may decide how to split first/last if needed; here we store full name)
            mergedFields = UserFields(
                name: name,
                password: mergedFields.password,
                email: mergedFields.email,
                profileImage: mergedFields.profileImage // temporary; will adjust below
            )

            // Handle attachments: if profileImageURL is provided, send it as a single attachment URL.
            // Since your UserFields stores profileImage as a String, we store the URL string there
            // and UsersAPI.putUser will convert it to an attachment array.
            if let newURL = profileImageURL, !newURL.isEmpty {
                mergedFields = UserFields(
                    name: mergedFields.name,
                    password: mergedFields.password,
                    email: mergedFields.email,
                    profileImage: newURL
                )
            } else {
                // Preserve existing image string (which should be a URL if present).
                // If you ever want to clear the image, pass profileImageURL = "" explicitly and handle that here.
            }

            // 3) PUT full merged fields
            let updated = try await api.putUser(recordID: profile.recordID, fullFields: mergedFields)

            // 4) Update local ProfileModel
            // We only update the display name pieces; here we simply set firstName to the new name and keep lastName.
            // If your "name" is a full name, you might want to split it; for now we assign it to firstName.
            profile.firstName = name
            // Optionally keep lastName as-is, or you can split name into first/last.
            // profile.lastName = ...

            // If you want to reflect the new avatar immediately and you have a way to download it, you could kick off a lightweight image fetch here.
            // For now, we leave profile.avatar unchanged; you can add image loading if desired.

            isLoading = false
        } catch {
            self.errorMessage = error.localizedDescription
            self.isLoading = false
        }
    }
}
