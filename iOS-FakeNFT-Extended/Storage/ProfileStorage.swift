//
//  ProfileStorage.swift
//  iOS-FakeNFT-Extended
//
//  Created by Vitaly Lobov on 26.06.2025.
//

import Foundation

final class ProfileStorage {
    private let defaults = UserDefaults.standard

    var name: String {
        get { defaults.string(forKey: UserDefaults.Keys.userProfileName) ?? "" }
        set { defaults.set(newValue, forKey: UserDefaults.Keys.userProfileName) }
    }

    var description: String {
        get { defaults.string(forKey: UserDefaults.Keys.userProfileDescription) ?? "" }
        set { defaults.set(newValue, forKey: UserDefaults.Keys.userProfileDescription) }
    }
}
