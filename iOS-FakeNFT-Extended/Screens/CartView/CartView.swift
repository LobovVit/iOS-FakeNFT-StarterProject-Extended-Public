import SwiftUI

struct CartView: View {
    private enum Constants {
        static let sortIconSize: CGFloat = 42
    }
    
    // MARK: - Properties
    
    @ObservedObject var viewModel: CartViewModel
    @State private var isShowingSortDialog = false
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            sorting
            nftList
            priceSection
        }
        
        .confirmationDialog(
            String(localized: "Sorting"),
            isPresented: $isShowingSortDialog,
            titleVisibility: .visible
        ) {
            ForEach(CartSortType.allCases) { type in
                Button(LocalizedStringKey(type.rawValue)) {
                    viewModel.selectSort(type)
                    isShowingSortDialog = false
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
                isShowingSortDialog = true
            }) {
                Image("SortIcon")
                    .resizable()
                    .frame(width: Constants.sortIconSize, height: Constants.sortIconSize)
                    .padding(.trailing, 9)
            }
        }
        .frame(height: Constants.sortIconSize)
        .background(Color.whiteDynamicYP)
    }
    
    private var nftList: some View {
        Group {
            if viewModel.loadingState == .loading {
                VStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
            } else {
                List {
                    ForEach(viewModel.items) { nft in
                        CartCell(
                            item: nft,
                            onRemove: { onTapRemove(nft) }
                        )
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets())
                        .padding(16)
                    }
                }
                .listStyle(PlainListStyle())
                .padding(.top, 20)
            }
        }
    }
    
    private var priceSection: some View {
        // TODO: добавить секцию с ценой
        EmptyView()
    }
    
    private func onTapRemove(_ item: CartItem) {
        viewModel.tapRemoveNft(item)
        viewModel.openRemoveModal()
    }
}

#Preview {
    CartView(viewModel: CartViewModel())
}
