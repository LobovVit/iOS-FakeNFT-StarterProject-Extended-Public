//
//  OnboardingStorage.swift
//  iOS-FakeNFT-Extended
//
//  Created by Vitaly Lobov on 26.06.2025.
//

import Foundation

final class OnboardingStorage {
    private let defaults = UserDefaults.standard

    var isCompleted: Bool {
        get { defaults.bool(forKey: UserDefaults.Keys.isOnboardingCompleted) }
        set { defaults.set(newValue, forKey: UserDefaults.Keys.isOnboardingCompleted) }
    }
}
