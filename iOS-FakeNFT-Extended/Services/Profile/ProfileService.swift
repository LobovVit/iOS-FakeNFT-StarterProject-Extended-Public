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
    func refreshProfile() async throws -> UserProfile
    func updateFavorites(id: String) async throws
}

final class ProfileService: ProfileServiceProtocol {
    private let networkClient: NetworkClient
    private let profileStorage: ProfileStorage
    private let favoritesStorage: FavoritesStorage

    init(
        networkClient: NetworkClient = DefaultNetworkClient.shared,
        profileStorage: ProfileStorage = .shared,
        favoritesStorage: FavoritesStorage = .shared
    ) {
        self.networkClient = networkClient
        self.profileStorage = profileStorage
        self.favoritesStorage = favoritesStorage
    }

    /// Возвращает профиль из локального хранилища или загружает из сети
    func fetchProfile() async throws -> UserProfile {
        if let stored = profileStorage.load() {
            return stored
        } else {
            let fetched = try await refreshProfile()
            return fetched
        }
    }

    /// Принудительно загружает данные из сети и обновляет локальное хранилище
    func refreshProfile() async throws -> UserProfile {
        let request = BasicRequest<UserProfile>(
            endpoint: ProfileRequestConstants.profileURL,
            httpMethod: .get
        )

        let profile: UserProfile = try await networkClient.send(request: request)
        profileStorage.save(profile)
        return profile
    }

    /// Обновляет профиль на сервере и сохраняет локально
    func updateProfile(_ profile: UserProfile) async throws {
        let body: [String: String] = [
            "name": profile.name,
            "description": profile.description,
            "website": profile.website,
            "avatar": profile.avatar ?? "",
            "likes": profile.likes.isEmpty ? "null" : profile.likes.joined(separator: ",")
        ]

        let request = BasicRequest<UserProfile>(
            endpoint: ProfileRequestConstants.profileURL,
            httpMethod: .put,
            rawBody: urlEncodedBody(from: body),
        )

        let updatedProfile = try await networkClient.send(request: request) as UserProfile
        profileStorage.save(updatedProfile)
    }
    
    /// Обновляет избранные на сервере и сохраняет локально
    func updateFavorites(id: String) async throws {
        favoritesStorage.toggleFavorite(id: id)
        guard var profile = profileStorage.load() else {
            return
        }
        let body: [String: String] = [
            "likes": profile.likes.isEmpty ? "null" : profile.likes.joined(separator: ",")
        ]

        let request = BasicRequest<UserProfile>(
            endpoint: ProfileRequestConstants.profileURL,
            httpMethod: .put,
            rawBody: urlEncodedBody(from: body),
        )

        let updatedProfile = try await networkClient.send(request: request) as UserProfile
        profileStorage.save(updatedProfile)
    }
    
    private func urlEncodedBody(from params: [String: String]) -> Data? {
        var components = URLComponents()
        components.queryItems = params.map { URLQueryItem(name: $0, value: $1) }
        return components.percentEncodedQuery?.data(using: .utf8)
    }
}
