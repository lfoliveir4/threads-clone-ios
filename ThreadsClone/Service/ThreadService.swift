import FirebaseFirestore

struct ThreadService {    
    static func uploadThread(_ thread: Thread) async throws {
        guard let data = try? Firestore.Encoder().encode(thread) else { return }
        try await Firestore
            .firestore()
            .collection(Constants.COLLECTION_THREADS)
            .addDocument(data: data)
    }

    static func fetch() async throws -> [Thread] {
        let snapshot = try await Firestore
            .firestore()
            .collection(Constants.COLLECTION_THREADS)
            .order(by: "timestamp", descending: true)
            .getDocuments()

        return snapshot.documents.compactMap { try? $0.data(as: Thread.self) }
    }

    static func fetchUserThreads(uid: String) async throws -> [Thread] {
        let snapshot = try await Firestore
            .firestore()
            .collection(Constants.COLLECTION_THREADS)
            .whereField("ownerUID", isEqualTo: uid)
            .getDocuments()

        let threads = snapshot.documents.compactMap { try? $0.data(as: Thread.self) }

        return threads.sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue() })
    }
}
