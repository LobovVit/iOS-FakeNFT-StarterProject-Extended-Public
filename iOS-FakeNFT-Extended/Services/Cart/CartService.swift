protocol CartServiceProtocol {
    func fetchCartItems() async -> [CartItem]
}

final class CartService: CartServiceProtocol {
    // TODO: заменить моковый вызов
    func fetchCartItems() async -> [CartItem] {
        try? await Task.sleep(for: .seconds(1))
        return CartItemMock.data
    }
}
