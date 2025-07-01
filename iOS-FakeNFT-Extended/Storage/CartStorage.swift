//
//  CartStorage.swift
//  iOS-FakeNFT-Extended
//
//  Created by Demain Petropavlov on 01.07.2025.
//

import SwiftUI

final class CartStorage {
    private let defaults = UserDefaults.standard
    private let key = "cartNFTIDs"

    var cartNFTIDs: [String] {
        get {
            defaults.stringArray(forKey: key) ?? []
        }
        set {
            defaults.set(newValue, forKey: key)
        }
    }

    func toggleCart(id: String) {
        var current = Set(cartNFTIDs)
        if current.contains(id) {
            current.remove(id)
        } else {
            current.insert(id)
        }
        cartNFTIDs = Array(current)
    }
}
