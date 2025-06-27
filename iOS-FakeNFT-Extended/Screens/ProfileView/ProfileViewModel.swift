//
//  ProfileViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Vitaly Lobov on 27.06.2025.
//

import Foundation
import SwiftUI

@MainActor
final class ProfileViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var description: String = ""
    @Published var website: String = ""
    @Published var avatarImageData: Data? = nil
    @Published var isLoading = false
    @Published var error: String? = nil

    private let storage = ProfileStorage()

    init() {
        loadProfile()
    }

    func loadProfile() {
        name = storage.name
        description = storage.description
        website = storage.website
        avatarImageData = storage.avatarImageData
    }

    func saveProfile() {
        storage.name = name
        storage.description = description
        storage.website = website
        storage.avatarImageData = avatarImageData
    }
}
