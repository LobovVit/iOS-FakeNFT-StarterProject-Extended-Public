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
    @Published var profile: UserProfile = .init(id: "", name: "", description: "", website: "", avatar: nil, nfts: [],likes: [])

    // Навигационное состояние
    @Published var isEditing: Bool = false
    @Published var showWebView: Bool = false
    @Published var navigateToMyNFT: Bool = false
    @Published var navigateToAbout: Bool = false
    @Published var loadingState: LoadingState = .default

    private let profileService: ProfileServiceProtocol
    private let profileStorage: ProfileStorage

        init(profileService: ProfileServiceProtocol = ProfileService(),
             profileStorage: ProfileStorage = .shared) {
            self.profileService = profileService
            self.profileStorage = profileStorage
            Task {
                await loadProfile()
            }
        }

    func loadProfile() async {
        loadingState = .loading
        do {
            let profile = try await profileService.fetchProfile()
            self.profile = profile
            loadingState = .success
            profileStorage.save(profile)
        } catch {
            loadingState = .failure
        }
    }

    func saveProfile() async {
        let updated = profile
        do {
            try await profileService.updateProfile(updated)
        } catch {
            print("❌ Не удалось сохранить профиль: \(error)")
        }
    }

    var displayName: String {
        profile.name.isEmpty ? NSLocalizedString("Name not specified", comment: "") : profile.name
    }

    var favoritesCount: Int {
        profile.likes.count
    }

    var myCount: Int {
        profile.nfts.count
    }

    var validWebsiteURL: URL? {
        if profile.website.lowercased().hasPrefix("http") {
            return URL(string: profile.website)
        } else {
            return URL(string: "https://\(profile.website)")
        }
    }

    var hasWebsite: Bool {
        !profile.website.isEmpty && validWebsiteURL != nil
    }

    var hasDescription: Bool {
        !profile.description.isEmpty
    }
}
