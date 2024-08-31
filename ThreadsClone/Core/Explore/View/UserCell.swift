import SwiftUI

struct UserCell: View {
    private let user: User

    init(user: User) {
        self.user = user
    }

    var body: some View {
        HStack {
            CircularProfileImageView(user: user, size: .small)

            VStack(alignment: .leading) {
                Text(user.username)
                    .fontWeight(.semibold)

                Text(user.fullname)
            }
            .font(.footnote)

            Spacer()

            Text("Follow")
                .font(.subheadline)
                .fontWeight(.semibold)
                .frame(width: 100, height: 32)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.systemGray4), lineWidth: 1)
                }
        }
        .padding(.horizontal)
    }
}

struct UserCell_Previews: PreviewProvider {
    static var previews: some View {
        UserCell(user: mock.user)
    }
}
