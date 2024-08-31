import SwiftUI

struct CurrentUserProfileView: View {
    @StateObject var viewModel = CurrentUserProfileViewModel()
    @State private var selectedFilter: ProfileThreadFilter = .threads
    @Namespace var animation
    @State var showProfile = false
    @StateObject var profileViewModel = ProfileViewModel()

    private var filterBarWidth: CGFloat {
        let count = CGFloat(ProfileThreadFilter.allCases.count)
        return UIScreen.main.bounds.width / count - 16
    }

    var currentUser: User? {
        viewModel.currentUser
    }

    var body: some View {
        if currentUser == nil {
            ProgressView()
        } else {
            loadedView
        }
    }

    var loadedView: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 12) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(currentUser?.fullname ?? "")
                                    .font(.title2)
                                    .fontWeight(.bold)

                                Text(currentUser?.username ?? "")
                                    .font(.subheadline)
                            }

                            if let bio = currentUser?.bio {
                                Text(bio)
                                    .font(.footnote)
                            }

                            Text("2 Followers")
                                .font(.caption)
                                .foregroundStyle(.gray)
                        }

                        Spacer()

                        CircularProfileImageView(user: currentUser, size: .medium)
                    }

                    Button {
                        showProfile.toggle()
                    } label: {
                        Text("Edit Profile")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.black)
                            .frame(width: 352, height: 32)
                            .background(.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color(.systemGray4), lineWidth: 1)
                            )
                    }

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
                            ForEach(profileViewModel.threads) { thread in
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
        }
        .sheet(isPresented: $showProfile) {
            if let user = currentUser {
                EditProfileView(user: user)
            }
        }
        .task {
            try? await profileViewModel.fetchUserThreads(id: currentUser?.id ?? "")
        }
    }
}

#Preview {
    CurrentUserProfileView()
}
