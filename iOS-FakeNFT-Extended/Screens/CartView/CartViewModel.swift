import SwiftUI
import Observation

@Observable
class CartViewModel {
    var isShowingSortDialog = false
    var isShowingRemoveModal = false
    var selectedSort: CartSortType
    var selectedNft: CartItem? = nil
    var items: [CartItem] = []
    var loadingState: LoadingState = .default
    
    private let sortStorage = CartSortStorage()
    private let service: CartServiceProtocol
    
    init(service: CartServiceProtocol = CartService()) {
        self.service = service
        self.selectedSort = sortStorage.selectedSort
        fetchItems()
        applySort(selectedSort)
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
    
    private func fetchItems() {
        loadingState = .loading
        Task {
            let result = await service.fetchCartItems()
            self.items = result
            self.loadingState = .success
        }
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
