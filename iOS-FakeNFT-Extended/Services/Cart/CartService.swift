enum CartServiceError: Error {
    case fetchOrderError
    case fetchNFTError(id: String)
    case updateOrderError
    case fetchCurrenciesError
    case PayOrderError
    case clearCartError
}

final class CartService: CartServiceProtocol {
    static let shared = CartService()
    
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient = DefaultNetworkClient.shared) {
        self.networkClient = networkClient
    }
    
    func fetchOrder() async throws -> Order {
        let request = FetchOrderRequest()
        do {
            return try await networkClient.send(request: request)
        } catch {
            throw CartServiceError.fetchOrderError
        }
    }
    
    func fetchCartItems(by ids: [String]) async throws -> [CartItem] {
        try await withThrowingTaskGroup(of: CartItem.self) { group in
            for id in ids {
                group.addTask {
                    let request = FetchNFTByIdRequest(id: id)
                    do {
                        return try await self.networkClient.send(request: request)
                    } catch {
                        throw CartServiceError.fetchNFTError(id: id)
                    }
                }
            }
            
            var result: [CartItem] = []
            for try await item in group {
                result.append(item)
            }
            
            return result
        }
    }
    
    func fetchCurrencies() async throws -> [Currency] {
        let request = FetchCurrenciesRequest()
        do {
            return try await networkClient.send(request: request)
        } catch {
            throw CartServiceError.fetchCurrenciesError
        }
    }
    
    func updateOrder(nftIds: [String]) async throws {
        let request = UpdateOrderRequest(nftIds: nftIds)
        do {
            _ = try await networkClient.send(request: request)
        } catch {
            throw CartServiceError.updateOrderError
        }
    }
    
    func payOrder(currencyId: String) async throws -> Bool {
        let request = PayOrderRequest(currencyId: currencyId)
        do {
            let response: PaymentResponse = try await networkClient.send(request: request)
            return response.success
        } catch {
            throw CartServiceError.PayOrderError
        }
    }
    
    func clearCart() async throws {
        let request = ClearCartRequest()
        do {
            _ = try await networkClient.send(request: request)
        } catch {
            throw CartServiceError.clearCartError
        }
    }
}
