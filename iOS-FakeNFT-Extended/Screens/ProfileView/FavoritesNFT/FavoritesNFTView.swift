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
                if viewModel.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if viewModel.sortedNFTs.isEmpty {
                    Text(String(localized: "You don't have any featured NFTs yet"))
                        .font(Fonts.bodyBold)
                        .multilineTextAlignment(.center)
                        .padding()
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(viewModel.sortedNFTs) { nft in
                                FavoriteNFTCardView(nft: nft) {
                                    Task {
                                        await viewModel.toggleFavorite(for: nft.id)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .navigationTitle(String(localized: "Featured NFTs"))
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
            .confirmationDialog(String(localized: "Sorting"), isPresented: $showSortDialog, titleVisibility: .visible) {
                ForEach(SortStorage.SortOption.allCases, id: \.self) { option in
                    if option != SortStorage.SortOption.byCount {
                        Button(sortTitle(for: option)) {
                            viewModel.selectedSortOption = option
                        }
                    }
                }
                Button(String(localized: "Close"), role: .cancel) {}
            }
            .alert(String(localized: "Error"), isPresented: Binding<Bool>(
                get: { viewModel.errorMessage != nil },
                set: { _ in viewModel.errorMessage = nil }
            )) {
                Button(String(localized: "Ok"), role: .cancel) { }
            } message: {
                Text(viewModel.errorMessage ?? "")
            }
        }
    }
    
    private func sortTitle(for option: SortStorage.SortOption) -> String {
        switch option {
        case .byPrice: return String(localized: "By price")
        case .byRating: return String(localized: "By rating")
        case .byName: return String(localized: "By name")
        case .byCount: return String(localized: "By count")
        }
    }
}

struct FavoritesNFTView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesNFTView()
    }
}
