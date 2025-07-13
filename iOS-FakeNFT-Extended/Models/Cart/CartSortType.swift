enum CartSortType: String, CaseIterable, Identifiable {
    case price = "By price"
    case rating = "By rating"
    case name = "By name"
    
    var id: String { self.rawValue }
}
