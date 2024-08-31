import SwiftUI

struct ThreadCell: View {
    let thread: Thread

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            CircularProfileImageView(user: thread.user, size: .small)

            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text("lewishamilton")
                        .font(.footnote)
                    .fontWeight(.semibold)

                    Spacer()

                    Text("10min")
                        .font(.caption)
                        .foregroundStyle(Color(.systemGray3))

                    Button(action: { }, label: {
                        Image(systemName: "ellipsis")
                            .foregroundStyle(Color(.darkGray))
                    })
                }

                Text(thread.caption)
                    .font(.footnote)
                    .multilineTextAlignment(.leading)

                HStack(spacing: 16) {
                    Button(action: {}, label: {
                        Image(systemName: "heart")

                    })

                    Button(action: {}, label: {
                        Image(systemName: "bubble.right")

                    })

                    Button(action: {}, label: {
                        Image(systemName: "arrow.rectanglepath")

                    })

                    Button(action: {}, label: {
                        Image(systemName: "paperplane")

                    })
                }
                .foregroundStyle(.black)
                .padding(.vertical, 8)
            }
        }
        .padding()

        Divider()
    }
}

struct ThreadCell_Previews: PreviewProvider {
    static var previews: some View {
        ThreadCell(thread: mock.thread)
    }
}
