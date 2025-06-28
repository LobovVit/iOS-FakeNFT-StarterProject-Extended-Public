//
//  FavoritesStorage.swift
//  iOS-FakeNFT-Extended
//
//  Created by Vitaly Lobov on 26.06.2025.
//

import Foundation

final class FavoritesStorage {
    private let defaults = UserDefaults.standard

    var favoriteNFTIDs: [String] {
        get {
            defaults.stringArray(forKey: UserDefaults.Keys.favoriteNFTIDs) ?? []
        }
        set {
            defaults.set(newValue, forKey: UserDefaults.Keys.favoriteNFTIDs)
        }
    }

    func toggleFavorite(id: String) {
        var current = Set(favoriteNFTIDs)
        if current.contains(id) {
            current.remove(id)
        } else {
            current.insert(id)
        }
        favoriteNFTIDs = Array(current)
    }
}
