//
//  FavoritesNFTView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Vitaly Lobov on 30.06.2025.
//

import SwiftUI

struct FavoritesNFTView: View {
    @StateObject private var viewModel = FavoritesNFTViewModel()

    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        VStack {
            if viewModel.nfts.isEmpty {
                Text("У Вас ещё нет избранных NFT")
                    .font(Fonts.bodyBold)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
                    .padding()
            } else {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(viewModel.nfts) { nft in
                            FavoriteNFTCardView(nft: nft)
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationTitle("Избранные NFT")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.loadFavorites()
        }
    }
}

struct FavoritesNFTView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesNFTView_PreviewWrapper()
    }

    struct FavoritesNFTView_PreviewWrapper: View {
        @StateObject private var viewModel = FavoritesNFTViewModel()

        var body: some View {
            FavoritesNFTView()
                .onAppear {
                    viewModel.nfts = MockData.nfts.filter { $0.isFavorite }
                }
        }
    }
}
