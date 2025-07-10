import SwiftUI

struct CartView: View {
    
    // MARK: - Properties
    
    @ObservedObject var viewModel: CartViewModel
    @State private var path: [CartRoute] = []
    @State private var isShowingSortDialog = false
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack(path: $path) {
            Group {
                switch viewModel.loadingState {
                case .loading:
                    loadingCartView
                case .success where viewModel.items.isEmpty:
                    emptyCartView
                case .success where !viewModel.items.isEmpty:
                    VStack(spacing: 0) {
                        sorting
                        nftList
                        priceSection
                    }
                case .failure:
                    errorCartView
                default:
                    EmptyView()
                }
            }
            
            // Окно сортировки nft
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
            
            .navigationDestination(for: CartRoute.self) { route in
                cartDestination(for: route)
            }
        }
        .modifier(CustomNavStyleModifier())
    }
    
    // MARK: - Content
    
    private var loadingCartView: some View {
        VStack {
            Spacer()
            ProgressView()
                .tint(.gray)
            Spacer()
        }
    }
    
    private var errorCartView: some View {
        VStack {
            Spacer()
            Text(String(localized: "Error"))
                .font(Fonts.bodyBold)
                .foregroundColor(.blackDynamicYP)
            Spacer()
        }
    }
    
    private var emptyCartView: some View {
        VStack {
            Spacer()
            Text(String(localized: "Cart is empty"))
                .font(Fonts.bodyBold)
                .foregroundColor(.blackDynamicYP)
            Spacer()
        }
    }
    
    private var sorting: some View {
        HStack {
            Spacer()
            
            Button(action: {
                isShowingSortDialog = true
            }) {
                Image("SortIcon")
                    .resizable()
                    .frame(width: CartViewConstants.sortIconSize, height: CartViewConstants.sortIconSize)
                    .padding(.trailing, 9)
            }
        }
        .frame(height: CartViewConstants.sortIconSize)
        .background(Color.whiteDynamicYP)
    }
    
    private var nftList: some View {
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
            
            Button {
                path.append(CartRoute.payment)
            } label: {
                Text(String(localized: "To payment"))
                    .font(Fonts.bodyBold)
                    .foregroundColor(.whiteDynamicYP)
                    .frame(width: CartViewConstants.buttonWidth, height: CartViewConstants.buttonHeight)
                    .background(.blackDynamicYP)
                    .cornerRadius(CartViewConstants.buttonCornerRadius)
            }
        }
        .padding(.horizontal, 16)
        .frame(height: CartViewConstants.priceSectionHeight)
        .background(.lightGreyDynamicYP)
        .cornerRadius(CartViewConstants.priceSectionRadius, corners: [.topLeft, .topRight])
    }
    
    // MARK: - Navigation Destination
    
    @ViewBuilder
    private func cartDestination(for route: CartRoute) -> some View {
        switch route {
        case .payment:
            PaymentView(
                viewModel: viewModel,
                onSuccess: {
                    path.append(.successfulPayment)
                }
            )
        case .successfulPayment:
            SuccessfulPaymentView(
                onReturnToCart: {
                    path.removeLast(path.count)
                }
            )
        }
    }
    
    // MARK: - Actions
    
    private func onTapRemove(_ item: CartItem) {
        viewModel.tapRemoveNft(item)
        viewModel.openRemoveModal()
    }
}

#Preview {
    CartView(viewModel: CartViewModel())
}
