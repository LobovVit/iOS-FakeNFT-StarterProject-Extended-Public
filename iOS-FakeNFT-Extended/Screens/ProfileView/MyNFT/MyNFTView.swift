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
                if viewModel.sortedNFTs.isEmpty {
                    Text("У Вас ещё нет NFT")
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
            .navigationTitle("Мои NFT")
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

struct MyNFTView_Previews: PreviewProvider {
    static var previews: some View {
        MyNFTView()
    }
}
