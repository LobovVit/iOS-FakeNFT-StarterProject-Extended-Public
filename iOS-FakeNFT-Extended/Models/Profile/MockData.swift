//
//  MockData.swift
//  iOS-FakeNFT-Extended
//
//  Created by Vitaly Lobov on 30.06.2025.
//

import Foundation

struct MockData {
    static let nfts: [NFTModel] = [
        NFTModel(id: "1", name: "Lilo", author: "John Doe", price: 1.79, rating: 4, imageURL: URL(string: "https://example.com/image1.png")!, isFavorite: false),
        NFTModel(id: "2", name: "Spring", author: "John Doe", price: 1.78, rating: 3, imageURL: URL(string: "https://example.com/image2.png")!, isFavorite: true),
        NFTModel(id: "3", name: "My little pony", author: "John Doe", price: 2.79, rating: 4, imageURL: URL(string: "https://example.com/image3.png")!, isFavorite: true),
        NFTModel(id: "4", name: "Pink", author: "John Doe", price: 2.78, rating: 1, imageURL: URL(string: "https://example.com/image4.png")!, isFavorite: true),
        NFTModel(id: "5", name: "Yellow bunny", author: "John Doe", price: 3.79, rating: 2, imageURL: URL(string: "https://example.com/image5.png")!, isFavorite: true),
        NFTModel(id: "6", name: "Red fox", author: "John Doe", price: 3.78, rating: 3, imageURL: URL(string: "https://example.com/image6.png")!, isFavorite: true)
    ]
}
