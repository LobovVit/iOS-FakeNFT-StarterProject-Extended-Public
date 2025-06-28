//
//  CatalogView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Demain Petropavlov on 28.06.2025.
//

import SwiftUI
import Kingfisher

struct CatalogView: View {
    @StateObject private var viewModel = CatalogViewModel()

    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView("Загрузка...")
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                } else {
                    List(viewModel.collections) { collection in
                        NavigationLink(destination: CollectionDetailView(collection: collection, nfts: viewModel.nfts(for: collection.id))) {
                            HStack {
                                KFImage(URL(string: collection.cover))
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 60, height: 60)
                                    .cornerRadius(8)
                                Text(collection.name)
                                    .font(.headline)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Каталог")
        }
        .task {
            await viewModel.loadData()
        }
    }
}
