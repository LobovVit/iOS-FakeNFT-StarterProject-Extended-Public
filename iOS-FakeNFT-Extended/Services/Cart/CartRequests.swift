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

struct FetchCurrenciesRequest: NetworkRequest {
    var rawBody: Data?
    
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)\(RequestConstants.currencies)")
    }
}

struct PayOrderRequest: NetworkRequest {
    let currencyId: String
    var rawBody: Data?
    
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)\(RequestConstants.payment)\(currencyId)")
    }
}

struct ClearCartRequest: NetworkRequest {
    var rawBody: Data? {
        let bodyString = RequestConstants.nftsNull
        return bodyString.data(using: .utf8)
    }
    
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)\(RequestConstants.orders)\(RequestConstants.orderId)")
    }
    
    var httpMethod: HttpMethod { .put }
    
    var headers: [String : String]? {
        ["Content-Type": "application/x-www-form-urlencoded"]
    }
}
