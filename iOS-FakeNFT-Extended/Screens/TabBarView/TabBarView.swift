import SwiftUI

struct TabBarView: View {
    @StateObject var cartViewModel = CartViewModel()
    @State private var selectedTab: TabModel = .profile
    
    init(){
        UITabBar.appearance().unselectedItemTintColor = .blackDynamicYP
    }
    
    var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {
                ProfileView()
                    .tabItem {
                        TabItemView(imageName: "ProfileNoActive", titleKey: "Profile")
                    }
                    .tag(TabModel.profile)
                
                CatalogView(viewModel: CatalogViewModel())
                    .tabItem {
                        TabItemView(imageName: "CatalogNoActive", titleKey: "Catalog")
                    }
                    .tag(TabModel.catalog)
                
                CartView(viewModel: cartViewModel)
                    .tabItem {
                        TabItemView(imageName: "BasketNoActive", titleKey: "Cart")
                    }
                    .tag(TabModel.cart)
            }
            .tint(.blueUniversalYP)
            .blur(radius: cartViewModel.isShowingRemoveModal ? 40 : 0)
            .animation(.easeInOut, value: cartViewModel.isShowingRemoveModal)
            
            removeCartItemModal
        }
        .animation(.easeInOut, value: cartViewModel.isShowingRemoveModal)
        .onChange(of: selectedTab) { _, newValue in
            if newValue == .cart {
                cartViewModel.reloadData()
            }
        }
    }
    
    @ViewBuilder
    private var removeCartItemModal: some View {
        if cartViewModel.isShowingRemoveModal {
            Color.whiteDynamicYP.opacity(0.05)
                .ignoresSafeArea()
                .transition(.opacity)
            
            CartModalView(
                imageURL: cartViewModel.selectedNft?.images[0],
                onTapRemoveAction: cartViewModel.removeNft,
                onTapReturnAction: cartViewModel.closeRemoveModal
            )
            .transition(.scale.combined(with: .opacity))
        }
    }
}

#Preview {
    TabBarView()
}
