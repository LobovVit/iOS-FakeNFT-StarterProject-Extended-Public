import SwiftUI

struct CartView: View {
    var body: some View {
        VStack {
            sorting
            nftList
            priceSection
        }
    }
    
    private var sorting: some View {
        // TODO: добавить сортировку
        EmptyView()
    }
    
    private var nftList: some View {
        List {
            ForEach(CartItemMock.data) { nft in
                CartCell(item: nft)
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets())
                    .padding(16)
            }
        }
        .listStyle(PlainListStyle())
        // TODO: поменять цвет
        .background(.white)
    }
    
    private var priceSection: some View {
        // TODO: добавить секцию с ценой
        EmptyView()
    }
}

#Preview {
    CartView()
}
