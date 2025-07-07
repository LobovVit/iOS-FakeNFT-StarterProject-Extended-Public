//
//  FavoritesNFTViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Vitaly Lobov on 30.06.2025.
//

import Foundation

@MainActor
final class FavoritesNFTViewModel: ObservableObject {
    @Published var errorMessage: String? = nil
    @Published var allNFTs: [NFTModel] = []
    @Published var sortedNFTs: [NFTModel] = []
    @Published var selectedSortOption: SortStorage.SortOption {
        didSet {
            sortStorage.selectedSortOption = selectedSortOption
            sortAndUpdateNFTs()
        }
    }
    
    private let sortStorage = SortStorage()
    private let nftService: NFTServiceProtocol
    private let profileService: ProfileServiceProtocol
    
    init(
        nftService: NFTServiceProtocol = NFTService(),
        profileService: ProfileServiceProtocol = ProfileService(),
    ) {
        self.nftService = nftService
        self.profileService = profileService
        self.selectedSortOption = sortStorage.selectedSortOption
        
        Task {
            await loadNFTs()
        }
    }
    
    func toggleFavorite(for id: String) async {
        do {
            try await profileService.updateFavorites(id: id)
        } catch {
            await MainActor.run {
                self.errorMessage = "Ошибка обновления избранных NFT: \(error.localizedDescription)"
            }
        }
        await loadNFTs()
    }
    
    func loadNFTs() async {
        do {
            let profile = try await profileService.fetchProfile()
            
            let loadedNFTs = try await withThrowingTaskGroup(of: NFTModel.self) { group in
                for nftID in profile.likes {
                    group.addTask {
                        try await self.nftService.fetchNFT(by: nftID)
                    }
                }
                
                var results: [NFTModel] = []
                for try await nft in group {
                    results.append(nft)
                }
                return results
            }
            
            self.allNFTs = loadedNFTs
            sortAndUpdateNFTs()
        } catch {
            await MainActor.run {
                self.errorMessage = "Ошибка загрузки профиля или избранных NFT: \(error.localizedDescription)"
            }
        }
    }
    
    func sortAndUpdateNFTs() {
        switch selectedSortOption {
        case .byName:
            sortedNFTs = allNFTs.sorted { $0.name < $1.name }
        case .byPrice:
            sortedNFTs = allNFTs.sorted { $0.price < $1.price }
        case .byRating:
            sortedNFTs = allNFTs.sorted { $0.rating > $1.rating }
        }
    }
}
