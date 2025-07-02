//
//  MockData.swift
//  iOS-FakeNFT-Extended
//
//  Created by Vitaly Lobov on 30.06.2025.
//

import Foundation

struct MockData {
    static let nfts: [NFTModel] = [
        NFTModel(
            id: "1",
            createdAt: "2023-04-20T02:22:27Z",
            name: "Lilo",
            images: ["https://example.com/image1.png"],
            rating: 4,
            description: "Lilo NFT description.",
            price: 1.79,
            author: "John Doe"
        ),
        NFTModel(
            id: "2",
            createdAt: "2023-04-20T02:22:27Z",
            name: "Spring",
            images: ["https://example.com/image2.png"],
            rating: 3,
            description: "Spring NFT description.",
            price: 1.78,
            author: "John Doe"
        ),
        NFTModel(
            id: "3",
            createdAt: "2023-04-20T02:22:27Z",
            name: "My little pony",
            images: ["https://example.com/image3.png"],
            rating: 4,
            description: "My little pony NFT description.",
            price: 2.79,
            author: "John Doe"
        ),
        NFTModel(
            id: "4",
            createdAt: "2023-04-20T02:22:27Z",
            name: "Pink",
            images: ["https://example.com/image4.png"],
            rating: 1,
            description: "Pink NFT description.",
            price: 2.78,
            author: "John Doe"
        ),
        NFTModel(
            id: "5",
            createdAt: "2023-04-20T02:22:27Z",
            name: "Yellow bunny",
            images: ["https://example.com/image5.png"],
            rating: 2,
            description: "Yellow bunny NFT description.",
            price: 3.79,
            author: "John Doe"
        ),
        NFTModel(
            id: "6",
            createdAt: "2023-04-20T02:22:27Z",
            name: "Red fox",
            images: ["https://example.com/image6.png"],
            rating: 3,
            description: "Red fox NFT description.",
            price: 3.78,
            author: "John Doe"
        )
    ]
}
