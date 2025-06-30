import Foundation
import SwiftUI

final class ProfileViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var description: String = ""
    @Published var website: String = ""
    @Published var avatarImageData: Data?

    // Навигационное состояние
    @Published var isEditing: Bool = false
    @Published var showWebView: Bool = false
    @Published var navigateToMyNFT: Bool = false
    @Published var navigateToAbout: Bool = false

    var displayName: String {
        name.isEmpty ? NSLocalizedString("Name not specified", comment: "") : name
    }

    var validWebsiteURL: URL? {
        if website.lowercased().hasPrefix("http") {
            return URL(string: website)
        } else {
            return URL(string: "https://\(website)")
        }
    }

    var hasWebsite: Bool {
        !website.isEmpty && validWebsiteURL != nil
    }

    var hasDescription: Bool {
        !description.isEmpty
    }
}
