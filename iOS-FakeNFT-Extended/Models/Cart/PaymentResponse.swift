import Foundation

struct PaymentResponse: Codable {
    let success: Bool
    let orderId: String
    let id: String
}
