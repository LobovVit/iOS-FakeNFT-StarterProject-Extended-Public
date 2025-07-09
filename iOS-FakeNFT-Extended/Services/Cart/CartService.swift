enum CartServiceError: Error {
    case fetchOrderError
    case fetchNFTError(id: String)
}

final class CartService: CartServiceProtocol {
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
}
