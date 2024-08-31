import Combine

final class ExploreViewModel: ObservableObject {
    @Published var users = [User]()

    init() {
        Task { try await fetchUsers() }
    }

    @MainActor
    private func fetchUsers() async throws {
        users = try await UserService.fetchUsers()
    }
}
