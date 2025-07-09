import Foundation

struct FetchCartItemsRequest: NetworkRequest {
    var rawBody: Data?
    
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/nft")
    }
}
