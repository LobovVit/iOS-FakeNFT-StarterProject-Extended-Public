import Foundation

struct FetchOrderRequest: NetworkRequest {
    var rawBody: Data?
    
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)\(RequestConstants.orders)")
    }
}

struct FetchNFTByIdRequest: NetworkRequest {
    let id: String
    var rawBody: Data?

    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)\(RequestConstants.nft)\(id)")
    }
}
