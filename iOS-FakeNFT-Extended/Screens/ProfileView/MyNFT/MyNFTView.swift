//
//  MyNFTView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Vitaly Lobov on 30.06.2025.
//

import SwiftUI

struct MyNFTView: View {
    @StateObject private var viewModel = MyNFTViewModel()
    @State private var showSortSheet = false

    var body: some View {
        VStack {
            if viewModel.nfts.isEmpty {
                Text("У Вас ещё нет NFT")
                    .font(Fonts.bodyBold)
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                List {
                    ForEach(viewModel.sortedNFTs) { nft in
                        NFTCardView(nft: nft)
                    }
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle("Мои NFT")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showSortSheet.toggle()
                } label: {
                    Image(systemName: "line.3.horizontal.decrease")
                }
            }
        }
        .confirmationDialog("Сортировка", isPresented: $showSortSheet) {
            ForEach(SortOption.allCases, id: \.self) { option in
                Button(option.title) {
                    viewModel.sortOption = option
                }
            }
            Button("Закрыть", role: .cancel) {}
        }
        .onAppear {
            viewModel.loadNFTs()
        }
    }
}

struct MyNFTView_Previews: PreviewProvider {
    static var previews: some View {
        MyNFTView()
    }
}
