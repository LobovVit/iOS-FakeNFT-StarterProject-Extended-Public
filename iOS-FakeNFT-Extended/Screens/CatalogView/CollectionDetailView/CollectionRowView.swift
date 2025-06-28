//
//  CollectionDetailView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Demain Petropavlov on 28.06.2025.
//

import SwiftUI
import Kingfisher

struct CollectionRowView: View {
    let collection: CollectionDTO
    let nfts: [NFTItem]

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            if let url = URL(string: collection.cover) {
                KFImage(url)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 140)
                    .frame(maxWidth: .infinity)
                    .clipped()
                    .cornerRadius(12)
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 140)
                    .frame(maxWidth: .infinity)
                    .cornerRadius(12)
            }

            Text("\(collection.name) (\(nfts.count))")
                .font(.headline)
                .padding(.top, 4)
        }
        .padding(.horizontal, 16)
    }
}

//MARK: - Preview
struct CollectionRowView_Previews: PreviewProvider {
    static var previews: some View {
        let mockCollection = CollectionDTO(
            id: "1",
            name: "Peach",
            cover: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQFeqJJ-e2ZCJ9eFVcfwkBRzzT7L_H_YPiMAw&s",
            description: "Sample collection",
            author: "Author",
            nfts: ["nft1", "nft2", "nft3"]
        )

        let mockNFTs: [NFTItem] = [
            NFTItem(
                id: "nft1",
                name: "NFT 1",
                images: ["https://cs13.pikabu.ru/post_img/big/2021/02/16/6/1613467870136564911.jpg"],
                rating: 5,
                description: "Cute NFT 1",
                price: 1.99,
                author: "Author"
            ),
            NFTItem(
                id: "nft2",
                name: "NFT 2",
                images: ["https://cs13.pikabu.ru/post_img/big/2021/02/16/6/1613467870136564911.jpg"],
                rating: 4,
                description: "Cute NFT 2",
                price: 2.49,
                author: "Author"
            ),
            NFTItem(
                id: "nft3",
                name: "NFT 3",
                images: ["https://cs13.pikabu.ru/post_img/big/2021/02/16/6/1613467870136564911.jpg"],
                rating: 3,
                description: "Cute NFT 3",
                price: 3.00,
                author: "Author"
            )
        ]

        return CollectionRowView(collection: mockCollection, nfts: mockNFTs)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

