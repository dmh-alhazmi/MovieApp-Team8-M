import Foundation
import Combine

@MainActor
final class UsersViewModel: ObservableObject {
    @Published var users: [UserRecord] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let api = UsersAPI()

    func load() {
        isLoading = true
        errorMessage = nil

        Task {
            do {
                let records = try await api.fetchAllUsers()
                self.users = records
                self.isLoading = false
            } catch {
                self.errorMessage = error.localizedDescription
                self.isLoading = false
            }
        }
    }
}

