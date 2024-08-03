import SwiftUI

struct FeedView: View {
    var body: some View {
        Text("Feed View")

        Button(action: {
            AuthenticationService.shared.logout()
        }, label: {
            Text("Try Logout")
        })
        .padding(.top, 20)
    }
}

#Preview {
    FeedView()
}
