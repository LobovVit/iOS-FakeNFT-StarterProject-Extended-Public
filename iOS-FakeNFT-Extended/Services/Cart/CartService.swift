protocol CartServiceProtocol {
    func fetchCartItems() async throws -> [CartItem]
}

final class CartService: CartServiceProtocol {
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient = DefaultNetworkClient.shared) {
        self.networkClient = networkClient
    }
    
    func fetchCartItems() async throws -> [CartItem] {
        let request = FetchCartItemsRequest()
        return try await networkClient.send(request: request)
    }
}
