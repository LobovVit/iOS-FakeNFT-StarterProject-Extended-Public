//
//  ProfileStorage.swift
//  iOS-FakeNFT-Extended
//
//  Created by Vitaly Lobov on 26.06.2025.
//

import Foundation

final class ProfileStorage {
    static let shared = ProfileStorage()

    private let defaults = UserDefaults.standard
    private let key = UserDefaults.Keys.userProfile

    // In-memory кеш
    private var cachedProfile: UserProfile?

    private init() {}

    func save(_ profile: UserProfile) {
        cachedProfile = profile
        if let data = try? JSONEncoder().encode(profile) {
            defaults.set(data, forKey: key)
        }
    }

    func load() -> UserProfile? {
        if let cachedProfile = cachedProfile {
            return cachedProfile
        }
        guard let data = defaults.data(forKey: key),
              let profile = try? JSONDecoder().decode(UserProfile.self, from: data) else {
            return nil
        }
        cachedProfile = profile
        return profile
    }

    func clear() {
        cachedProfile = nil
        defaults.removeObject(forKey: key)
    }
}

