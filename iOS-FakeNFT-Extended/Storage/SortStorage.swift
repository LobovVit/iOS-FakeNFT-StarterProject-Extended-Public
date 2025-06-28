//
//  SortStorage.swift
//  iOS-FakeNFT-Extended
//
//  Created by Vitaly Lobov on 26.06.2025.
//

import Foundation

final class SortStorage {
    private let defaults = UserDefaults.standard

    enum SortOption: String, CaseIterable {
        case byName = "name"
        case byPrice = "price"
        case byRating = "rating"
    }

    var selectedSortOption: SortOption {
        get {
            if let rawValue = defaults.string(forKey: UserDefaults.Keys.selectedSortOption),
               let option = SortOption(rawValue: rawValue) {
                return option
            } else {
                return .byName
            }
        }
        set {
            defaults.set(newValue.rawValue, forKey: UserDefaults.Keys.selectedSortOption)
        }
    }
}


// Пример использования в ViewModel:

//class CatalogViewModel: ObservableObject {
//    private let sortStorage = SortStorage()
//
//    @Published var currentSort: SortStorage.SortOption {
//        didSet {
//            sortStorage.selectedSortOption = currentSort
//        }
//    }
//
//    init() {
//        self.currentSort = sortStorage.selectedSortOption
//    }
//}
