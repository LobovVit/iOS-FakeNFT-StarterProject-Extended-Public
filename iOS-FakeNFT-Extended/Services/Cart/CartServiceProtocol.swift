protocol CartServiceProtocol {
    func fetchOrder() async throws -> Order
    func fetchCartItems(by: [String]) async throws -> [CartItem]
    func fetchCurrencies() async throws -> [Currency]
    func updateOrder(nftIds: [String]) async throws
}
