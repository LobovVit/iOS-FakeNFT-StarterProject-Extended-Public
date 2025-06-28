//
//  CollectionDetailView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Demain Petropavlov on 28.06.2025.
//

import SwiftUI
import Kingfisher

struct CollectionDetailView: View {
    let collection: CollectionDTO
    let nfts: [NFTItem]

    var body: some View {
        List(nfts) { nft in
            HStack {
                if let imageURL = nft.images.first, let url = URL(string: imageURL) {
                    KFImage(url)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 60, height: 60)
                        .cornerRadius(8)
                } else {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 60, height: 60)
                        .cornerRadius(8)
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text(nft.name)
                        .font(.headline)
                    Text("Цена: \(nft.price, specifier: "%.2f") ₽")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            .padding(.vertical, 4)
        }
        .navigationTitle(collection.name)
    }
}



