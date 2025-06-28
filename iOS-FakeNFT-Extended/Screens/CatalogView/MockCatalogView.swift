//
//  MockCatalogView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Vitaly Lobov on 26.06.2025.
//

// Заглушки основных экранов для MainTabView (удалить после собственной реализации)

import SwiftUI

// MARK: - CatalogView
struct CatalogView: View {
    var body: some View {
        NavigationStack {
            Text(String(localized: "Catalog"))
                .navigationTitle(String(localized: "Catalog"))
        }
    }
}
