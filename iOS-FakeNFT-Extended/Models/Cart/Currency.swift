import Foundation

struct Currency: Identifiable {
    let id = UUID()
    let title: String
    let name: String
    let imageURL: String
}

struct CurrencyMock {
    static let data: [Currency] = [
        Currency(title: "Bitcoin", name: "ВТС", imageURL: "https://loremflickr.com/600/600"),
        Currency(title: "Dogecoin", name: "DOGE", imageURL: "https://loremflickr.com/600/600"),
        Currency(title: "Tether", name: "USDT", imageURL: "https://loremflickr.com/600/600"),
        Currency(title: "Bitcoin", name: "ВТС", imageURL: "https://loremflickr.com/600/600"),
        Currency(title: "Dogecoin", name: "DOGE", imageURL: "https://loremflickr.com/600/600"),
        Currency(title: "Tether", name: "USDT", imageURL: "https://loremflickr.com/600/600")
    ]
}
