//
//  ProfileViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Vitaly Lobov on 26.06.2025.
//

import Foundation
import SwiftUI

@MainActor
final class ProfileViewModel: ObservableObject {
    @Published var id: String = ""
    @Published var name: String = ""
    @Published var description: String = ""
    @Published var website: String = ""
    @Published var avatarImageData: Data?

    // Навигационное состояние
    @Published var isEditing: Bool = false
    @Published var showWebView: Bool = false
    @Published var navigateToMyNFT: Bool = false
    @Published var navigateToAbout: Bool = false
    @Published var loadingState: LoadingState = .default

    private let profileService: ProfileServiceProtocol

        init(profileService: ProfileServiceProtocol = ProfileService()) {
            self.profileService = profileService
        }

    func loadProfile() async {
        loadingState = .loading
        do {
            let profile = try await profileService.fetchProfile()
            self.name = profile.name
            self.description = profile.description
            self.website = profile.website
            self.avatarImageData = profile.avatarImageData
            loadingState = .success
        } catch {
            loadingState = .failure
        }
    }

    func saveProfile() async {
        let updated = UserProfile(
            id: id,
            name: name,
            description: description,
            website: website,
            avatarImageData: avatarImageData
        )

        do {
            try await profileService.updateProfile(updated)
        } catch {
            print("❌ Не удалось сохранить профиль: \(error)")
        }
    }

    var displayName: String {
        name.isEmpty ? NSLocalizedString("Name not specified", comment: "") : name
    }

    var favoritesCount: Int {
        MockData.nfts.filter { $0.isFavorite }.count
    }

    var myCount: Int {
        MockData.nfts.count
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
