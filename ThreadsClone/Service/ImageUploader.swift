import FirebaseStorage
import UIKit

enum ImageUploader {
    static func upload(_ image: UIImage) async throws -> String? {
        guard let imageData = image.jpegData(compressionQuality: 0.25) else { return nil }
        let fileName = NSUUID().uuidString
        let storageReference = Storage.storage().reference(withPath: "/profile_images/\(fileName)")

        do {
            let _ = try await storageReference.putDataAsync(imageData)
            let url = try await storageReference.downloadURL()
            return url.absoluteString
        } catch {
            debugPrint("error to upload profile image: \(error.localizedDescription)")
            return nil
        }
    }
}
