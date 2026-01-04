import Foundation

// Helper for Airtable attachments
struct AirtableAttachment: Codable, Equatable {
    let url: String
    // You can add filename, type, etc., if needed:
    // let filename: String?
    // let type: String?
}

// Airtable error payload
struct AirtableAPIErrorEnvelope: Codable {
    struct APIError: Codable {
        let type: String
        let message: String
    }
    let error: APIError
}

struct UsersAPI {
    private let baseURL = URL(string: "https://api.airtable.com/v0/appsfcB6YESLj4NCN")!

    // Read token from generated Secrets.swift (do not hard-code tokens)
    private var authHeader: String {
        "Bearer \(Secrets.apiToken)"
    }

    // Existing: fetch all users
    func fetchAllUsers() async throws -> [UserRecord] {
        let url = baseURL.appendingPathComponent("users")
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(authHeader, forHTTPHeaderField: "Authorization")

        let (data, response) = try await URLSession.shared.data(for: request)
        try throwIfHTTPError(response: response, data: data)

        let decoded = try JSONDecoder().decode(UsersResponse.self, from: data)
        return decoded.records
    }

    // NEW: fetch a single user record by record ID
    func getUser(recordID: String) async throws -> UserRecord {
        let url = baseURL.appendingPathComponent("users").appendingPathComponent(recordID)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(authHeader, forHTTPHeaderField: "Authorization")

        let (data, response) = try await URLSession.shared.data(for: request)
        try throwIfHTTPError(response: response, data: data)

        let decoded = try JSONDecoder().decode(UserRecord.self, from: data)
        return decoded
    }

    // NEW: PUT full fields to replace record (merge performed by caller)
    func putUser(recordID: String, fullFields: UserFields) async throws -> UserRecord {
        let url = baseURL.appendingPathComponent("users").appendingPathComponent(recordID)
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue(authHeader, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        // Build a payload that matches Airtable's expected input:
        // { "fields": { ... } }
        struct Payload: Codable {
            let fields: EncodableUserFields
        }

        // Because your existing UserFields has simple types, we mirror it here with attachment support.
        struct EncodableUserFields: Codable {
            let name: String
            let password: String
            let email: String
            let profile_image: [AirtableAttachment]

            enum CodingKeys: String, CodingKey {
                case name, password, email
                case profile_image
            }
        }

        // Map your model to the payload structure.
        // Note: Your current UserFields.profileImage is a String. For attachments, we need an array.
        // We'll interpret the stored string as a URL when building attachments; callers should pass
        // attachments via merging logic before calling putUser.
        let attachments: [AirtableAttachment]
        if fullFields.profileImage.isEmpty {
            attachments = []
        } else {
            attachments = [AirtableAttachment(url: fullFields.profileImage)]
        }

        let encodableFields = EncodableUserFields(
            name: fullFields.name,
            password: fullFields.password,
            email: fullFields.email,
            profile_image: attachments
        )

        let body = try JSONEncoder().encode(Payload(fields: encodableFields))
        request.httpBody = body

        let (data, response) = try await URLSession.shared.data(for: request)
        try throwIfHTTPError(response: response, data: data)

        let decoded = try JSONDecoder().decode(UserRecord.self, from: data)
        return decoded
    }

    // Common error handler: throw descriptive errors for non-2xx
    private func throwIfHTTPError(response: URLResponse, data: Data) throws {
        guard let http = response as? HTTPURLResponse else { return }
        guard (200..<300).contains(http.statusCode) else {
            if let env = try? JSONDecoder().decode(AirtableAPIErrorEnvelope.self, from: data) {
                let message = "HTTP \(http.statusCode): \(env.error.type) – \(env.error.message)"
                throw NSError(domain: "UsersAPI", code: http.statusCode, userInfo: [NSLocalizedDescriptionKey: message])
            } else {
                let body = String(data: data, encoding: .utf8) ?? ""
                throw NSError(domain: "UsersAPI", code: http.statusCode, userInfo: [NSLocalizedDescriptionKey: "HTTP \(http.statusCode): \(body)"])
            }
        }
    }
}
