import Combine
import Firebase

@MainActor
final class ProfileViewModel: ObservableObject {
    @Published var threads = [Thread]()

    func fetchUserThreads(id: String) async throws {
        threads = try await ThreadService.fetchUserThreads(uid: id)
    }
}
