//
//  MyNFTViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Vitaly Lobov on 30.06.2025.
//

import Foundation

@MainActor
final class MyNFTViewModel: ObservableObject {
    @Published var nfts: [NFTModel] = []
    @Published var sortedNFTs: [NFTModel] = []

    @Published var selectedSortOption: SortStorage.SortOption {
        didSet {
            sortStorage.selectedSortOption = selectedSortOption
            sortAndUpdateNFTs()
        }
    }

    private let sortStorage = SortStorage()
    private let nftService: NFTServiceProtocol
    private let profileStorage: ProfileStorage

    init(
        nftService: NFTServiceProtocol = NFTService(),
        profileStorage: ProfileStorage = .shared
    ) {
        self.nftService = nftService
        self.profileStorage = profileStorage
        self.selectedSortOption = sortStorage.selectedSortOption

        Task {
            await loadNFTs()
        }
    }

    func loadNFTs() async {
        guard let profile = profileStorage.load() else {
            print("⚠️ Profile not found in storage")
            return
        }

        var loadedNFTs: [NFTModel] = []

        await withTaskGroup(of: NFTModel?.self) { group in
            for id in profile.nfts {
                group.addTask {
                    do {
                        return try await self.nftService.fetchNFT(by: id)
                    } catch {
                        print("❌ Failed to load NFT with id \(id): \(error)")
                        return nil
                    }
                }
            }

            for await result in group {
                if let nft = result {
                    loadedNFTs.append(nft)
                }
            }
        }

        self.nfts = loadedNFTs
        sortAndUpdateNFTs()
    }

    func sortAndUpdateNFTs() {
        switch selectedSortOption {
        case .byName:
            sortedNFTs = nfts.sorted { $0.name < $1.name }
        case .byPrice:
            sortedNFTs = nfts.sorted { $0.price < $1.price }
        case .byRating:
            sortedNFTs = nfts.sorted { $0.rating > $1.rating }
        }
    }
}
