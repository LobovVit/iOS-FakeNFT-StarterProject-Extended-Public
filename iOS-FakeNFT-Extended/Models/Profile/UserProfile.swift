//
//  UserProfile.swift
//  iOS-FakeNFT-Extended
//
//  Created by Vitaly Lobov on 26.06.2025.
//

import Foundation

struct UserProfile: Codable, Identifiable {
    let id: String
    var name: String
    var description: String
    var website: String
    var avatarImageData: Data?
}
