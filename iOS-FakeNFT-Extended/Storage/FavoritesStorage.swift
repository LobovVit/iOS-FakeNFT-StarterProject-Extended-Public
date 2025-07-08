//
//  FavoritesStorage.swift
//  iOS-FakeNFT-Extended
//
//  Created by Vitaly Lobov on 26.06.2025.
//

import Foundation

final class FavoritesStorage {
    private let profileStorage: ProfileStorage
    static let shared = FavoritesStorage()
    
    init(profileStorage: ProfileStorage = .shared) {
        self.profileStorage = profileStorage
    }
    
    var favoriteNFTIDs: [String] {
        profileStorage.load()?.likes ?? []
    }
    
    func toggleFavorite(id: String) {
        guard var profile = profileStorage.load() else {
            return
        }
        
        var current = Set(profile.likes)
        if current.contains(id) {
            current.remove(id)
        } else {
            current.insert(id)
        }
        
        profile.likes = Array(current)
        profileStorage.save(profile)
    }
}
