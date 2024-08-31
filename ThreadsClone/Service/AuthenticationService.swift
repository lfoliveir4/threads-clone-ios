import FirebaseAuth
import FirebaseFirestore

class AuthenticationService {
    @Published var userSession: FirebaseAuth.User?

    static let shared = AuthenticationService()

    init() {
        userSession = Auth.auth().currentUser
    }

    @MainActor func login(withEmail email: String, password: String) async throws {
        let result = try await Auth.auth().signIn(withEmail: email, password: password)
        userSession = result.user
        try? await UserService.shared.fetchCurrentUser()
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
        try? await uploadUserData(
            withEmail: email,
            fullname: fullName,
            username: username,
            id: result.user.uid
        )
        print("\(result.user.uid)")
    }

    func logout() {
        try? Auth.auth().signOut()
        userSession = nil
        UserService.shared.reset()
    }

    private func uploadUserData(
        withEmail email: String,
        fullname: String,
        username: String,
        id: String
    ) async throws {
        let user: User = .init(
            id: id,
            fullname: fullname,
            email: email,
            username: username
        )

        guard let data = try? Firestore.Encoder().encode(user) else { return }
        try? await Firestore.firestore().collection("users").document(id).setData(data)
        UserService.shared.currentUser = user
    }
}
