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
            if viewModel.isLoading {
                VStack {
                    Spacer()
                    ProgressView("Загрузка...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                    Spacer()
                }
            } else {
                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        Spacer().frame(height: 62)

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
            }

            // Кнопка сортировки
            if !viewModel.isLoading {
                Button(action: {
                    showSortDialog = true
                }) {
                    Image("SortIcon")
                }
                .frame(width: 42, height: 42)
                .padding(.top, 0)
                .padding(.trailing, 9)
            }
        }
        .confirmationDialog("Сортировка", isPresented: $showSortDialog, titleVisibility: .visible) {
            Button("По названию") {
                viewModel.sortCollections(by: .byName)
            }
            Button("По количеству NFT") {
                viewModel.sortCollections(by: .byCount)
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
        private let sortStorage = SortStorage()

        var body: some View {
            CatalogView(viewModel: viewModel)
                .onAppear {
                    sortStorage.selectedSortOption = .byCount
                    
                    viewModel.collections = [
                        CollectionDTO(id: "1",
                                      name: "Zeta",
                                      cover: "https://img.goodfon.ru/wallpaper/big/3/32/kotenok-mordochka-lapki-usy.webp",
                                      description: "",
                                      author: "",
                                      nfts: ["1", "2"]
                                     ),
                        CollectionDTO(id: "2",
                                      name: "Alpha",
                                      cover: "https://images.wallpaperscraft.ru/image/single/kotenok_milyj_lezhat_71887_1920x1080.jpg",
                                      description: "",
                                      author: "",
                                      nfts: ["1"]
                                     ),
                        CollectionDTO(id: "3",
                                      name: "Beta",
                                      cover: "https://img.freepik.com/free-photo/view-beautiful-persian-domestic-cat_23-2151773947.jpg?semt=ais_items_boosted&w=740",
                                      description: "",
                                      author: "",
                                      nfts: ["1", "2", "3"]
                                     )
                    ]

                    viewModel.nfts = [
                        NFTItem(id: "1",
                                name: "NFT #1",
                                images: [""],
                                rating: 4,
                                description: "",
                                price: 1.5,
                                author: ""
                               ),
                        NFTItem(id: "2",
                                name: "NFT #2",
                                images: [""],
                                rating: 5,
                                description: "",
                                price: 2.0,
                                author: ""
                               ),
                        NFTItem(id: "3",
                                name: "NFT #3",
                                images: [""],
                                rating: 3,
                                description: "",
                                price: 0.9,
                                author: ""
                               )
                    ]
                    viewModel.sortCollections()
                }
        }
    }
}
