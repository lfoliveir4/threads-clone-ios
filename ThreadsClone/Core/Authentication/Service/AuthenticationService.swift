import FirebaseAuth

class AuthenticationService {
    @Published var userSession: FirebaseAuth.User?

    static let shared = AuthenticationService()

    init() {
        userSession = Auth.auth().currentUser
    }

    @MainActor func login(withEmail email: String, password: String) async throws {
        let result = try await Auth.auth().signIn(withEmail: email, password: password)
        userSession = result.user
        print("\(result.user.uid)")
    }

    @MainActor func createUser(
        withEmail email: String,
        password: String,
        fullName: String,
        username: String
    ) async throws {
        let result = try await Auth.auth().createUser(withEmail: email, password: password)
        userSession = result.user
        print("\(result.user.uid)")
    }

    func logout() {
        try? Auth.auth().signOut()
        userSession = nil
    }
}
