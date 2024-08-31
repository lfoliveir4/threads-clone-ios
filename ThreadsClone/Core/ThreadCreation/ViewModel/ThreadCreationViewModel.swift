import Combine
import FirebaseAuth
import FirebaseCore

final class ThreadCreationViewModel: ObservableObject {
    func upload(_ caption: String) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let thread: Thread = .init(
            ownerUID: uid,
            caption: caption,
            timestamp: Timestamp(),
            likes: 0
        )
        try await ThreadService.uploadThread(thread)
    }
}
