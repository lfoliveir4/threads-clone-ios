import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    
    var body: some View {
        if viewModel.userSession != nil {
            FeedView()
        } else {
            LoginView()
        }
    }
}

#Preview {
    ContentView()
}
