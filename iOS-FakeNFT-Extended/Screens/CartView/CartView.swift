import SwiftUI

struct CartView: View {
    private enum Constants {
        static let sortIconSize: CGFloat = 42
        static let buttonWidth: CGFloat = 240
        static let buttonHeight: CGFloat = 44
        static let buttonCornerRadius: CGFloat = 16
        static let priceSectionHeight: CGFloat = 76
        static let priceSectionRadius: CGFloat = 20
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
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text("\(viewModel.items.count) NFT")
                    .font(Fonts.mediumRegular)
                    .foregroundColor(.blackDynamicYP)
                
                Text("\(viewModel.totalPrice, specifier: "%.2f") ETH")
                    .font(Fonts.bodyBold)
                    .foregroundColor(.greenUniversalYP)
            }
            
            Spacer()
            
            Button(action: {
                // TODO: Действие при нажатии на кнопку "К оплате"
            }) {
                Text(String(localized: "To payment"))
                    .font(Fonts.bodyBold)
                    .foregroundColor(.whiteDynamicYP)
                    .frame(width: Constants.buttonWidth, height: Constants.buttonHeight)
                    .background(.blackDynamicYP)
                    .cornerRadius(Constants.buttonCornerRadius)
            }
        }
        .padding(.horizontal, 16)
        .frame(height: Constants.priceSectionHeight)
        .background(.lightGreyDynamicYP)
        .cornerRadius(Constants.priceSectionRadius, corners: [.topLeft, .topRight])
    }
    
    private func onTapRemove(_ item: CartItem) {
        viewModel.tapRemoveNft(item)
        viewModel.openRemoveModal()
    }
}

#Preview {
    CartView(viewModel: CartViewModel())
}
