import SwiftUI

struct ProfileView: View {
    let user: User
    @State private var selectedFilter: ProfileThreadFilter = .threads
    @Namespace var animation
    @StateObject var viewModel = ProfileViewModel()

    private var filterBarWidth: CGFloat {
        let count = CGFloat(ProfileThreadFilter.allCases.count)
        return UIScreen.main.bounds.width / count - 16
    }

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 20) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 12) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(user.fullname)
                                .font(.title2)
                                .fontWeight(.bold)

                            Text(user.username)
                                .font(.subheadline)
                        }

                        if let bio = user.bio {
                            Text(bio)
                                .font(.footnote)
                        }

                        Text("2 Followers")
                            .font(.caption)
                            .foregroundStyle(.gray)
                    }

                    Spacer()

                    CircularProfileImageView(user: user, size: .medium)
                }

                Button(action: { }, label: {
                    Text("Follow")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .frame(width: 352, height: 32)
                        .background(.black)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                })

                VStack {
                    HStack {
                        ForEach(ProfileThreadFilter.allCases) { filter in
                            VStack {
                                Text(filter.title)
                                    .font(.subheadline)
                                    .fontWeight(selectedFilter == filter ? .semibold : .regular)

                                if selectedFilter == filter {
                                    Rectangle()
                                        .foregroundStyle(.black)
                                        .frame(width: filterBarWidth, height: 1)
                                        .matchedGeometryEffect(id: "item", in: animation)
                                } else {
                                    Rectangle()
                                        .foregroundStyle(.clear)
                                        .frame(width: filterBarWidth, height: 1)
                                }
                            }
                            .onTapGesture {
                                withAnimation(.spring()) {
                                    selectedFilter = filter
                                }
                            }
                        }
                    }

                    LazyVStack {
                        ForEach(viewModel.threads) { thread in
                            ThreadCell(thread: thread)
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        AuthenticationService.shared.logout()
                    } label: {
                        Image(systemName: "line.3.horizontal")
                    }
                }
            }
            .padding(.horizontal)
        }
        .task {
            try? await viewModel.fetchUserThreads(id: user.id)
        }
    }
}
