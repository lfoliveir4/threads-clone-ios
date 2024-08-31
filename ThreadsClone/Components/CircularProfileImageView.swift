import SwiftUI

enum ProfileImageSize {
    case xxSmall
    case xSmall
    case small
    case medium
    case large
    case xLarge

    var dimension: CGFloat {
        switch self {
        case .xxSmall: return 28
        case .xSmall: return 32
        case .small: return 40
        case .medium: return 48
        case .large: return 64
        case .xLarge: return 80
        }
    }
}

struct CircularProfileImageView: View {
    var user: User?
    let size: ProfileImageSize

    var body: some View {
        if let imageURL = user?.profileImageURL {
            image(imageURL)
        } else {
            fallback
        }
    }

    func image(_ url: String) -> some View {
        let imageURLConverted = URL(string: url)

        return AsyncImage(url: imageURLConverted) { image in
            image
                .image?.resizable()
                .scaledToFill()
                .frame(width: size.dimension, height: size.dimension)
                .clipShape(Circle())
        }
    }

    var fallback: some View {
        Image("lewis-hamilton")
            .resizable()
            .scaledToFill()
            .frame(width: size.dimension, height: size.dimension)
            .clipShape(Circle())
    }
}

struct CircularProfileImageView_Previews: PreviewProvider {
    static var previews: some View {
        CircularProfileImageView(
            user: mock.user,
            size: .medium
        )
    }
}
