import SwiftUI
import Observation

@Observable
class CartViewModel {
    var isShowingSortDialog = false
    var isShowingRemoveModal = false
    var selectedSort: CartSortType
    var selectedNft: CartItem? = nil
    var items: [CartItem] = CartItemMock.data
    
    private let sortStorage = CartSortStorage()
    
    init() {
        selectedSort = sortStorage.selectedSort
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
