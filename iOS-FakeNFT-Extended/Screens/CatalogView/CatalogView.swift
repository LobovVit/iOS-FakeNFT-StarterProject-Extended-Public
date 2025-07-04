//
//  CatalogView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Demain Petropavlov on 28.06.2025.
//

import SwiftUI
import Kingfisher
import StoreKit

struct CatalogView: View {
    @ObservedObject var viewModel: CatalogViewModel
    @State private var showSortDialog = false
    @State private var path = NavigationPath()
    @AppStorage("hasRequestedReviewCatalog") private var hasRequestedReview = false

    var body: some View {
        NavigationStack(path: $path) {
            ZStack(alignment: .topTrailing) {
                Color(.whiteDynamicYP)
                    .ignoresSafeArea()

                if viewModel.isLoading {
                    VStack {
                        Spacer()
                        ProgressView(String(localized: "Loading") + "...")
                            .progressViewStyle(CircularProgressViewStyle())
                            .padding()
                            .frame(maxWidth: .infinity)
                            .multilineTextAlignment(.center)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 0) {
                            Spacer().frame(height: 62)

                            LazyVStack(spacing: 21) {
                                ForEach(viewModel.collections) { collection in
                                    Button(action: {
                                        let nfts = viewModel.nfts(for: collection.id)
                                        path.append(CollectionNavigationRoute.detail(collection: collection, nfts: nfts))
                                    }) {
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

                if !viewModel.isLoading {
                    Button(action: {
                        showSortDialog = true
                    }) {
                        Image("SortIcon")
                            .renderingMode(.template)
                            .foregroundColor(.blackDynamicYP)
                    }
                    .frame(width: 42, height: 42)
                    .padding(.top, 0)
                    .padding(.trailing, 9)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .confirmationDialog(String(localized: "Sorting"), isPresented: $showSortDialog, titleVisibility: .visible) {
                Button(String(localized: "By name")) {
                    viewModel.sortCollections(by: .byName)
                }
                Button(String(localized: "By the number of NFTs")) {
                    viewModel.sortCollections(by: .byCount)
                }
                Button("Close", role: .cancel) {}
            }
            .navigationDestination(for: CollectionNavigationRoute.self) { route in
                switch route {
                case .detail(let collection, let nfts):
                    CollectionDetailView(
                        collection: collection,
                        viewModel: CollectionDetailViewModel(nfts: nfts)
                    )
                }
            }
            .task {
                await viewModel.loadData()

                if !hasRequestedReview,
                   let scene = UIApplication.shared.connectedScenes
                       .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
                    SKStoreReviewController.requestReview(in: scene)
                    hasRequestedReview = true
                }
            }
        }
    }
}

enum CollectionNavigationRoute: Hashable {
    case detail(collection: CollectionDTO, nfts: [NFTItem])
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
