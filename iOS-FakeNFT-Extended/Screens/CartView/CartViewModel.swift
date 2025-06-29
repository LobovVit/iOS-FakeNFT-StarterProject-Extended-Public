import SwiftUI

@MainActor
class CartViewModel: ObservableObject {
    @Published var isShowingSortDialog = false
    @Published var isShowingRemoveModal = false
    @Published var selectedSort: CartSortType
    @Published var selectedNft: CartItem? = nil
    @Published var items: [CartItem] = []
    @Published var loadingState: LoadingState = .default
    
    private let sortStorage = CartSortStorage()
    private let service: CartServiceProtocol
    
    init(service: CartServiceProtocol = CartService()) {
        self.service = service
        self.selectedSort = sortStorage.selectedSort
        
        Task {
            await fetchItems()
            applySort(selectedSort)
        }
    }
    
    func selectSort(_ type: CartSortType) {
        selectedSort = type
        isShowingSortDialog = false
        sortStorage.selectedSort = type
        applySort(type)
    }
    
    func tapRemoveNft(_ item: CartItem) {
        selectedNft = item
    }
    
    private func fetchItems() async {
        loadingState = .loading
        let result = await service.fetchCartItems()
        self.items = result
        loadingState = .success
    }
    
    private func applySort(_ type: CartSortType) {
        switch type {
        case .price:
            items.sort { $0.price < $1.price }
        case .rating:
            items.sort { $0.rating > $1.rating }
        case .name:
            items.sort { $0.name < $1.name }
        }
    }
}
