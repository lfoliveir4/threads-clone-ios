import Combine

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var loading: Bool = false

    private let service: AuthenticationService = .shared

    @MainActor
    func login() async throws {
        loading = true
        try await service.login(withEmail: email, password: password)
    }
}
