import Foundation

final class CartSortStorage: ObservableObject {
    private let defaults = UserDefaults.standard
    private let key = UserDefaults.Keys.selectedCartSortType

    var selectedSort: CartSortType {
        get {
            if let rawValue = defaults.string(forKey: key),
               let sortType = CartSortType(rawValue: rawValue) {
                return sortType
            } else {
                return .name
            }
        }
        set {
            defaults.set(newValue.rawValue, forKey: key)
        }
    }
}
