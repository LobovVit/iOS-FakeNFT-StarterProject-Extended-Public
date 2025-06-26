import Foundation

struct CartItem: Identifiable {
    let id = UUID()
    let imageURL: String
    let name: String
    let rating: Int
    let price: Double
}

struct CartItemMock {
    static let data: [CartItem] = [
        CartItem(imageURL: "https://loremflickr.com/600/600", name: "April", rating: 1, price: 1.78),
        CartItem(imageURL: "https://loremflickr.com/600/600", name: "Greena", rating: 3, price: 1.78),
        CartItem(imageURL: "https://loremflickr.com/600/600", name: "Spring", rating: 5, price: 1.78)
    ]
}
