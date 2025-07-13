import Foundation

struct Currency: Identifiable, Codable {
    let id: String
    let title: String
    let name: String
    let image: String
}

struct CurrencyMock {
    static let data: [Currency] = [
        Currency(id: "1", title: "Bitcoin", name: "ВТС", image: "https://loremflickr.com/600/600"),
        Currency(id: "2", title: "Dogecoin", name: "DOGE", image: "https://loremflickr.com/600/600")
    ]
}
