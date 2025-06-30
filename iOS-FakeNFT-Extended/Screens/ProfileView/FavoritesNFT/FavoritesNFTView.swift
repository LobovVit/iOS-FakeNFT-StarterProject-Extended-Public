//
//  FavoritesNFTView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Vitaly Lobov on 30.06.2025.
//

import SwiftUI

struct FavoritesNFTView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = FavoritesNFTViewModel()
    @State private var showSortDialog = false

    private let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.sortedNFTs.isEmpty {
                    Text("У Вас ещё нет избранных NFT")
                        .font(Fonts.bodyBold)
                        .multilineTextAlignment(.center)
                        .padding()
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(viewModel.sortedNFTs) { nft in
                                FavoriteNFTCardView(nft: nft)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .navigationTitle("Избранные NFT")
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.primary)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showSortDialog = true
                    } label: {
                        Image("SortIcon")
                            .foregroundColor(.primary)
                    }
                }
            }
            .confirmationDialog("Сортировка", isPresented: $showSortDialog, titleVisibility: .visible) {
                ForEach(SortStorage.SortOption.allCases, id: \.self) { option in
                    Button(sortTitle(for: option)) {
                        viewModel.selectedSortOption = option
                    }
                }
                Button("Закрыть", role: .cancel) {}
            }
        }
    }

    private func sortTitle(for option: SortStorage.SortOption) -> String {
        switch option {
        case .byPrice: return "По цене"
        case .byRating: return "По рейтингу"
        case .byName: return "По названию"
        }
    }
}

struct FavoritesNFTView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesNFTView()
    }
}
