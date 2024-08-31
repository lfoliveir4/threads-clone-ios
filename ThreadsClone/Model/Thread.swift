import FirebaseCore
import FirebaseFirestore

struct Thread: Identifiable, Codable {
    @DocumentID var threadId: String?
    let ownerUID: String
    let caption: String
    let timestamp: Timestamp
    var likes: Int
    var user: User?

    var id: String {
        return threadId ?? UUID().uuidString
    }
}
