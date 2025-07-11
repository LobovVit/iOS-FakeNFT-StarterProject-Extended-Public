import Foundation

struct FetchOrderRequest: NetworkRequest {
    var rawBody: Data?
    
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)\(RequestConstants.orders)\(RequestConstants.orderId)")
    }
}

struct FetchNFTByIdRequest: NetworkRequest {
    let id: String
    var rawBody: Data?
    
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)\(RequestConstants.nft)\(id)")
    }
}

struct UpdateOrderRequest: NetworkRequest {
    let nftIds: [String]
    var rawBody: Data? {
        urlEncodedArray(key: RequestConstants.nftsKey, values: nftIds)
    }
    
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)\(RequestConstants.orders)\(RequestConstants.orderId)")
    }
    
    var httpMethod: HttpMethod { .put }
    var dto: Encodable? { nil }
}
