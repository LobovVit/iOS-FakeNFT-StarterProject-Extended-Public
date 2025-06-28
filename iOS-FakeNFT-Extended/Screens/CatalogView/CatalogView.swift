//
//  CatalogView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Demain Petropavlov on 28.06.2025.
//

import SwiftUI
import Kingfisher

struct CatalogView: View {
    @ObservedObject var viewModel: CatalogViewModel
    @State private var showSortDialog = false

    var body: some View {
        ZStack(alignment: .topTrailing) {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    // Отступ сверху
                    Spacer().frame(height: 62) // 42 (высота кнопки) + 20 (отступ до коллекции)

                    // Ячейки коллекций
                    LazyVStack(spacing: 21) {
                        ForEach(viewModel.collections) { collection in
                            NavigationLink(
                                destination: CollectionRowView(
                                    collection: collection,
                                    nfts: viewModel.nfts(for: collection.id)
                                )
                            ) {
                                CollectionRowView(
                                    collection: collection,
                                    nfts: viewModel.nfts(for: collection.id)
                                )
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
            }

            // Кнопка сортировки
            Button(action: {
                showSortDialog = true
            }) {
                Image("SortIcon")
            }
            .frame(width: 42, height: 42)
            .padding(.top, 0)
            .padding(.trailing, 9)
        }
        .confirmationDialog("Сортировка", isPresented: $showSortDialog, titleVisibility: .visible) {
            Button("По названию") {
                viewModel.sortCollections(by: .name)
            }
            Button("По количеству NFT") {
                viewModel.sortCollections(by: .nftCount)
            }
            Button("Закрыть", role: .cancel) {}
        }
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.loadData()
        }
    }
}

// MARK: - Preview

struct CatalogView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CatalogViewPreviewWrapper()
        }
    }

    struct CatalogViewPreviewWrapper: View {
        @StateObject private var viewModel = CatalogViewModel()

        var body: some View {
            CatalogView(viewModel: viewModel)
                .onAppear {
                    viewModel.collections = (1...8).map { index in
                        CollectionDTO(
                            id: "\(index)",
                            name: "Коллекция \(index)",
                            cover: "https://www.fund4dogs.ru/wp-content/uploads/2024/06/1000097411-1.jpg",
                            description: "Описание коллекции \(index)",
                            author: "Автор \(index)",
                            nfts: ["1", "2"]
                        )
                    }

                    viewModel.nfts = [
                        NFTItem(
                            id: "1",
                            name: "NFT #1",
                            images: ["https://example.com/nft1.png"],
                            rating: 4,
                            description: "Описание NFT",
                            price: 1.5,
                            author: "Автор"
                        ),
                        NFTItem(
                            id: "2",
                            name: "NFT #2",
                            images: ["https://example.com/nft2.png"],
                            rating: 5,
                            description: "Описание NFT",
                            price: 2.0,
                            author: "Автор"
                        )
                    ]
                }
        }
    }
}
