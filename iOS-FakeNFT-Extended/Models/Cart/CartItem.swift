import Foundation

struct CartItem: Identifiable, Codable {
    let name: String
    let id: String
    let price: Double
    let rating: Int
    let images: [String]
}

struct CartItemMock {
    static let data: [CartItem] = [
        CartItem(name: "April", id: "1", price: 1.78, rating: 3, images: ["https://loremflickr.com/600/600"]),
        CartItem(name: "Spring", id: "2", price: 3.08, rating: 1, images: ["https://loremflickr.com/600/600"])
    ]
}
