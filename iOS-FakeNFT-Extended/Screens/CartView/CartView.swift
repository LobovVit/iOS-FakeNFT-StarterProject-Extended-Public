import SwiftUI

struct CartView: View {
    @State private var viewModel = CartViewModel()
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            VStack {
                sorting
                nftList
                priceSection
            }
            .blur(radius: viewModel.isShowingRemoveModal ? 40 : 0)
            
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
            
            if viewModel.isShowingRemoveModal {
                Color.whiteDynamicYP.opacity(0.05)
                    .ignoresSafeArea()
                    .transition(.opacity)
                
                CartModalView(viewModel: viewModel)
                    .transition(.scale.combined(with: .opacity))
            }
        }
        .animation(.easeInOut, value: viewModel.isShowingRemoveModal)
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
                        CartCell(item: nft, viewModel: viewModel)
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
}

#Preview {
    CartView()
}
