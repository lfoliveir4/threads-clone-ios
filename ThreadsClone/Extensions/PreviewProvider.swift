import SwiftUI
import FirebaseCore

extension PreviewProvider {
    static var mock: DeveloperPreview {
        return DeveloperPreview.shared
    }
}

final class DeveloperPreview {
    static let shared = DeveloperPreview()

    let user: User = .init(
        id: NSUUID().uuidString,
        fullname: "LF Oliveira",
        email: "lfoliveira.dev@gmail.com",
        username: "lfoliveira"
    )

    let thread: Thread = .init(
        ownerUID: "123",
        caption: "Thread Preview",
        timestamp: Timestamp(),
        likes: 0
    )
}
