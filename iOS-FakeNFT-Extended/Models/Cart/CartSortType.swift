enum CartSortType: String, CaseIterable, Identifiable {
    case price = "По цене"
    case rating = "По рейтингу"
    case name = "По названию"
    
    var id: String { self.rawValue }
}
