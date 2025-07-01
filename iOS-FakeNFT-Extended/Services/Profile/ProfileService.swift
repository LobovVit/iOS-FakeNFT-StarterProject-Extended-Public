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
        let request = BasicRequest<UserProfile>(
            endpoint: ProfileRequestConstants.URL,
            httpMethod: .get
        )

        return try await DefaultNetworkClient.shared.send(request: request)
    }

    func updateProfile(_ profile: UserProfile) async throws {
        let request = BasicRequest<UserProfile>(
            endpoint: ProfileRequestConstants.URL,
            httpMethod: .put,
            dto: profile
        )

        _ = try await DefaultNetworkClient.shared.send(request: request) as UserProfile
    }
}
