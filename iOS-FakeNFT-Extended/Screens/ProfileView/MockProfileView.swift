//
//  MockProfileView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Vitaly Lobov on 26.06.2025.
//

// Заглушки основных экранов для MainTabView (удалить после собственной реализации)

import SwiftUI

// MARK: - ProfileView
struct ProfileView: View {
    var body: some View {
        NavigationStack {
            Text(String(localized: "Profile"))
                .navigationTitle(String(localized: "Profile"))
        }
    }
}
