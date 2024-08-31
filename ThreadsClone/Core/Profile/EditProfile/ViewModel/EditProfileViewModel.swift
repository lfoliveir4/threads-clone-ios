import Combine
import PhotosUI
import SwiftUI

final class EditProfileViewModel: ObservableObject {
    @Published var profileImage: Image?
    @Published var photoSelected: PhotosPickerItem? {
        didSet {
            Task { await loadImage() }
        }
    }

    private var uiImage: UIImage?

    func update() async throws {
        try await updateProfileImage()
    }

    @MainActor
    private func loadImage() async {
        guard let item = photoSelected else { return }

        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: data) else { return }
        self.uiImage = uiImage
        profileImage = Image(uiImage: uiImage)
    }

    private func updateProfileImage() async throws {
        guard let image = uiImage else { return }
        guard let imageURL = try? await ImageUploader.upload(image) else { return }
        try? await UserService.shared.updateUserProfileImage(withImageURL: imageURL)
    }
}
