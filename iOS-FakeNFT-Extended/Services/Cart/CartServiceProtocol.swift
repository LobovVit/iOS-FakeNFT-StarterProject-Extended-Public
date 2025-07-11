protocol CartServiceProtocol {
    func fetchOrder() async throws -> Order
    func fetchCartItems(by: [String]) async throws -> [CartItem]
    func updateOrder(nftIds: [String]) async throws
}
