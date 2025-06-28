//
//  ProfileStorage.swift
//  iOS-FakeNFT-Extended
//
//  Created by Vitaly Lobov on 26.06.2025.
//

import Foundation

final class ProfileStorage {
    var name: String {
        get { UserDefaults.standard.string(forKey: "profile_name") ?? "" }
        set { UserDefaults.standard.set(newValue, forKey: "profile_name") }
    }

    var description: String {
        get { UserDefaults.standard.string(forKey: "profile_description") ?? "" }
        set { UserDefaults.standard.set(newValue, forKey: "profile_description") }
    }

    var website: String {
        get { UserDefaults.standard.string(forKey: "profile_website") ?? "" }
        set { UserDefaults.standard.set(newValue, forKey: "profile_website") }
    }

    var avatarImageData: Data? {
        get { UserDefaults.standard.data(forKey: "profile_avatarImageData") }
        set { UserDefaults.standard.set(newValue, forKey: "profile_avatarImageData") }
    }
}

