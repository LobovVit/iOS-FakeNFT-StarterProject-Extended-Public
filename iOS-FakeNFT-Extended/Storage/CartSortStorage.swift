import SwiftUI

final class CartSortStorage: ObservableObject {
    @AppStorage(UserDefaults.Keys.selectedCartSortType) var selectedSortRawValue: String = CartSortType.name.rawValue
    
    var selectedSort: CartSortType {
        get { CartSortType(rawValue: selectedSortRawValue) ?? .name }
        set { selectedSortRawValue = newValue.rawValue }
    }
}
