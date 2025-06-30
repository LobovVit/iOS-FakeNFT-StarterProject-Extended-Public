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

    init() {
        self.selectedSortOption = sortStorage.selectedSortOption
        loadNFTs()
    }

    func loadNFTs() {
        // пока мок
        self.nfts = MockData.nfts
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
