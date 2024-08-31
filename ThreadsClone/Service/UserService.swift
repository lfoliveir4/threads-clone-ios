import FirebaseFirestore
import FirebaseAuth

final class UserService {
    @Published var currentUser: User?

    static let shared = UserService()

    init() {
        Task { try? await fetchCurrentUser() }
    }

    @MainActor
    func fetchCurrentUser() async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let snapshot = try? await Firestore
            .firestore()
            .collection(Constants.COLLECTION_USERS)
            .document(uid)
            .getDocument()

        let user = try snapshot?.data(as: User.self)
        currentUser = user
    }

    static func fetchUsers() async throws -> [User] {
        guard let currentUid = Auth.auth().currentUser?.uid else { return [] }
        let snapshot = try await Firestore
            .firestore()
            .collection(Constants.COLLECTION_USERS)
            .getDocuments()

        let users = snapshot.documents.compactMap { try? $0.data(as: User.self) }
        return users.filter { $0.id != currentUid }
    }

    static func fetchUser(withUid uid: String) async throws -> User {
        let snapshot = try await Firestore
            .firestore()
            .collection(Constants.COLLECTION_USERS)
            .document()
            .getDocument()

        return try snapshot.data(as: User.self)
    }

    func reset() {
        currentUser = nil
    }

    func updateUserProfileImage(withImageURL imageURL: String) async throws {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        try await Firestore.firestore()
            .collection(Constants.COLLECTION_USERS)
            .document(currentUid)
            .updateData(["profileImageURL": imageURL])

        currentUser?.profileImageURL = imageURL
    }
}
