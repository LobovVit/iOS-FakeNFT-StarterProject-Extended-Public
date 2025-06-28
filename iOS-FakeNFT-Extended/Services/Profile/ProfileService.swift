//
//  ProfileService.swift
//  iOS-FakeNFT-Extended
//
//  Created by Vitaly Lobov on 26.06.2025.
//

import Foundation

protocol ProfileServiceProtocol {
    func fetchProfile() async throws -> UserProfile
    func updateProfile(_ profile: UserProfile) async throws
}

final class ProfileService: ProfileServiceProtocol {
    func fetchProfile() async throws -> UserProfile {
        // TODO: fetch from API
        return UserProfile(id: "1", name: "Имя", description: "О себе", website: "https://example.com")
    }

    func updateProfile(_ profile: UserProfile) async throws {
        // TODO: send update to API
    }
}
