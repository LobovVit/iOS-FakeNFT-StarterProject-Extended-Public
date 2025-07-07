//
//  MyNFTView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Vitaly Lobov on 30.06.2025.
//

import SwiftUI

struct MyNFTView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = MyNFTViewModel()
    @State private var showSortDialog = false
    
    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if viewModel.sortedNFTs.isEmpty {
                    Text(String(localized: "You don't have NFT yet"))
                        .font(Fonts.bodyBold)
                        .padding()
                } else {
                    ScrollView {
                        VStack(spacing: 12) {
                            ForEach(viewModel.sortedNFTs) { nft in
                                NFTCardView(nft: nft)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .navigationTitle(String(localized: "My NFTs"))
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.primary)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showSortDialog = true
                    }) {
                        Image("SortIcon")
                            .foregroundColor(.primary)
                    }
                }
            }
            .confirmationDialog(String(localized: "Sorting"), isPresented: $showSortDialog, titleVisibility: .visible) {
                ForEach(SortStorage.SortOption.allCases, id: \.self) { option in
                    Button(sortTitle(for: option)) {
                        viewModel.selectedSortOption = option
                    }
                }
                Button(String(localized: "Close"), role: .cancel) {}
            }
            .alert("Ошибка", isPresented: Binding<Bool>(
                get: { viewModel.errorMessage != nil },
                set: { _ in viewModel.errorMessage = nil }
            )) {
                Button("Ок", role: .cancel) { }
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
        }
    }
}

struct MyNFTView_Previews: PreviewProvider {
    static var previews: some View {
        MyNFTView()
    }
}
