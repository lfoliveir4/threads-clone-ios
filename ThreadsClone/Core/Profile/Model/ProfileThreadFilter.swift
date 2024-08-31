enum ProfileThreadFilter: Int, CaseIterable, Identifiable {
    case threads
    case replies

    var title: String {
        switch self {
        case .threads: "Threads"
        case .replies: "Replies"
        }
    }

    var id: Int { self.rawValue }
}
