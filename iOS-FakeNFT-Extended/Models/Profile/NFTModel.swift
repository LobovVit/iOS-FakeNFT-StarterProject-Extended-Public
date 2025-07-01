//
//  NFTModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Vitaly Lobov on 30.06.2025.
//

import Foundation

struct NFTModel: Identifiable {
    let id: String
    let name: String
    let author: String
    let price: Double
    let rating: Int
    let imageURL: URL
    let isFavorite: Bool
}
