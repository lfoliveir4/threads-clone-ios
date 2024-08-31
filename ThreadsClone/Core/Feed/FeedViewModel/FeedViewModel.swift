import Combine

@MainActor
final class FeedViewModel: ObservableObject {
    @Published var threads = [Thread]()

    init() {
        Task { try await fetchThreads() }
    }
    
    func fetchThreads() async throws {
        threads = try await ThreadService.fetch()
        try await fetchUserDataForThreads()
    }

    private func fetchUserDataForThreads() async throws {
        for i in 0..<threads.count {
            let thread = threads[i]
            let ownerUID = thread.ownerUID
            let threadUser = try await UserService.fetchUser(withUid: ownerUID)

            threads[i].user = threadUser
        }
    }
}
