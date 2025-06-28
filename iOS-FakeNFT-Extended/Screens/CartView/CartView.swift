import SwiftUI

struct CartView: View {
    @State private var viewModel = CartViewModel()
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            sorting
            nftList
            priceSection
        }
        .confirmationDialog(
            String(localized: "Sorting"),
            isPresented: $viewModel.isShowingSortDialog,
            titleVisibility: .visible
        ) {
            ForEach(CartSortType.allCases) { type in
                Button(type.rawValue) {
                    viewModel.selectSort(type)
                }
            }
            
            Button(String(localized: "Close"), role: .cancel) {}
        }
    }
    
    // MARK: - Content
    
    private var sorting: some View {
        HStack {
            Spacer()
            
            Button(action: {
                viewModel.isShowingSortDialog = true
            }) {
                Image("SortIcon")
                    .resizable()
                    .frame(width: 42, height: 42)
                    .padding(.trailing, 9)
            }
        }
        .frame(height: 42)
        .background(Color.whiteDynamicYP)
    }
    
    private var nftList: some View {
        List {
            ForEach(viewModel.items) { nft in
                CartCell(item: nft)
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets())
                    .padding(16)
            }
        }
        .listStyle(PlainListStyle())
        .padding(.top, 20)
    }
    
    private var priceSection: some View {
        // TODO: добавить секцию с ценой
        EmptyView()
    }
}

#Preview {
    CartView()
}
