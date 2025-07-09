import SwiftUI

@MainActor
final class CartViewModel: ObservableObject {
    
    // MARK: - UI Binding
    
    @Published var items: [CartItem] = []
    @Published var currencies: [Currency] = CurrencyMock.data
    @Published var selectedSort: CartSortType
    @Published var selectedNft: CartItem? = nil
    @Published var selectedCurrency: Currency? = nil
    @Published var isShowingRemoveModal = false
    @Published var loadingState: LoadingState = .default
    
    private let sortStorage = CartSortStorage()
    private let service: CartServiceProtocol
    
    var totalPrice: Double {
        items.reduce(0) { $0 + $1.price }
    }
    
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
        sortStorage.selectedSort = type
        applySort(type)
    }
    
    func selectCurrency(_ currency: Currency) {
        guard selectedCurrency?.id != currency.id else { return }
        selectedCurrency = currency
    }
    
    func tapRemoveNft(_ item: CartItem) {
        selectedNft = item
    }
    
    func openRemoveModal() {
        isShowingRemoveModal = true
    }
    
    func closeRemoveModal() {
        isShowingRemoveModal = false
    }
    
    func payOrder() async -> Bool {
        try? await Task.sleep(for: .seconds(1))
        let success = Bool.random()
        return success
    }
    
    func fetchItems() async {
        loadingState = .loading
        do {
            let order = try await service.fetchOrder()
            let cartItems = try await service.fetchCartItems(by: order.nfts)
            self.items = cartItems
            loadingState = .success
        } catch {
            print("Ошибка при загрузке корзины: \(error)")
            loadingState = .failure
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
