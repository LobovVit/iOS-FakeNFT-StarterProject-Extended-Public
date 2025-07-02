//
//  ProfileStorage.swift
//  iOS-FakeNFT-Extended
//
//  Created by Vitaly Lobov on 26.06.2025.
//

import Foundation

final class ProfileStorage {
    private let defaults = UserDefaults.standard
    private let key = UserDefaults.Keys.userProfile

    func save(_ profile: UserProfile) {
        if let data = try? JSONEncoder().encode(profile) {
            defaults.set(data, forKey: key)
        }
    }

    func load() -> UserProfile? {
        guard let data = defaults.data(forKey: key),
              let profile = try? JSONDecoder().decode(UserProfile.self, from: data) else {
            return nil
        }
        return profile
    }

    func clear() {
        defaults.removeObject(forKey: key)
    }
}

