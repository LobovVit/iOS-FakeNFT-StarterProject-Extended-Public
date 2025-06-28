//
//  CollectionDTO.swift
//  iOS-FakeNFT-Extended
//
//  Created by Vitaly Lobov on 26.06.2025.
//

struct CollectionDTO: Identifiable, Codable {
    let id: String
    let name: String
    let cover: String
    let description: String
    let author: String
    let nfts: [String]
}

