import SwiftUI

@MainActor
final class CartViewModel: ObservableObject {
    
    // MARK: - UI Binding
    
    @Published var items: [CartItem] = []
    @Published var orderId: String = ""
    @Published var currencies: [Currency] = []
    @Published var selectedSort: CartSortType
    @Published var selectedNft: CartItem? = nil
    @Published var selectedCurrencyId: String = ""
    @Published var isShowingRemoveModal = false
    @Published var loadingState: LoadingState = .default
    
    private let sortStorage = CartSortStorage()
    private let cartStorage = CartStorage.shared
    private let service: CartServiceProtocol
    
    var totalPrice: Double {
        items.reduce(0) { $0 + $1.price }
    }
    
    init(service: CartServiceProtocol = CartService.shared) {
        self.service = service
        self.selectedSort = sortStorage.selectedSort
        loadCurrenciesIfNeeded()
    }
    
    func reloadData() async {
        await fetchItems()
        applySort(selectedSort)
    }
    
    func loadCurrenciesIfNeeded() {
        if currencies.isEmpty {
            Task {
                do {
                    self.currencies = try await service.fetchCurrencies()
                } catch {
                    print("Ошибка загрузки валют: \(error)")
                }
            }
        }
    }
    
    func selectSort(_ type: CartSortType) {
        selectedSort = type
        sortStorage.selectedSort = type
        applySort(type)
    }
    
    func selectCurrency(_ currency: Currency) {
        guard selectedCurrencyId != currency.id else { return }
        selectedCurrencyId = currency.id
    }
    
    func selectNft(_ item: CartItem) {
        selectedNft = item
    }
    
    func openRemoveModal() {
        isShowingRemoveModal = true
    }
    
    func closeRemoveModal() {
        isShowingRemoveModal = false
    }
    
    func payOrder() async -> Bool {
        guard !selectedCurrencyId.isEmpty else {
            print("Ошибка: не выбран способ оплаты")
            return false
        }
        
        do {
            let success = try await service.payOrder(currencyId: selectedCurrencyId)
            
            if success {
                // Очистить корзину на сервере
                try await service.clearCart()
                
                // Очистить локальные данные корзины
                cartStorage.cartNFTIDs = []
                items = []
                selectedCurrencyId = ""
            }
            
            return success
        } catch {
            print("Ошибка при оплате заказа или очистке корзины: \(error)")
            return false
        }
    }
    
    func fetchItems() async {
        loadingState = .loading
        do {
            let order = try await service.fetchOrder()
            let cartItems = try await service.fetchCartItems(by: order.nfts)
            self.orderId = order.id
            self.items = cartItems
            loadingState = .success
        } catch {
            print("Ошибка при загрузке корзины: \(error)")
            loadingState = .failure
        }
    }
    
    func removeNft() {
        guard let selectedNft else { return }
        cartStorage.toggleCart(id: selectedNft.id)
        
        Task {
            do {
                try await updateCartOnServer()
                closeRemoveModal()
                await reloadData()
            } catch {
                print("Ошибка при обновлении корзины на сервере: \(error)")
            }
        }
    }
    
    private func updateCartOnServer() async throws {
        let updatedIds = cartStorage.cartNFTIDs
        try await service.updateOrder(nftIds: updatedIds)
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
