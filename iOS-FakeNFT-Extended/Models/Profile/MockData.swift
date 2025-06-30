//
//  MockData.swift
//  iOS-FakeNFT-Extended
//
//  Created by Vitaly Lobov on 30.06.2025.
//

import Foundation

struct MockData {
    static let nfts: [NFTModel] = [
        NFTModel(id: "1", name: "Lilo", author: "John Doe", price: 1.78, rating: 4, imageUrl: URL(string: "https://example.com/image1.png")!),
        NFTModel(id: "2", name: "Spring", author: "John Doe", price: 1.78, rating: 3, imageUrl: URL(string: "https://example.com/image2.png")!)
    ]
}
