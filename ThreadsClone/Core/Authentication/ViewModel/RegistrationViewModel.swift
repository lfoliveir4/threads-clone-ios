import Combine

class RegistrationViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var fullName = ""
    @Published var username = ""
    @Published var loading: Bool = false

    private let service: AuthenticationService = .shared
    
    @MainActor
    func createUser() async throws {
        loading = true
        try await service.createUser(
            withEmail: email,
            password: password,
            fullName: fullName,
            username: username
        )
        loading = false
    }
}
