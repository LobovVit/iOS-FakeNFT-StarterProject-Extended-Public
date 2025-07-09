import SwiftUI

struct TabBarView: View {
    @StateObject var cartViewModel = CartViewModel()
    
    init(){
        UITabBar.appearance().unselectedItemTintColor = .blackDynamicYP
    }
    
    var body: some View {
        ZStack {
            TabView {
                ProfileView()
                    .tabItem {
                        TabItemView(
                            imageName: "ProfileNoActive",
                            titleKey: "Profile"
                        )
                    }
                
                CatalogView(viewModel: CatalogViewModel())
                    .tabItem {
                        TabItemView(
                            imageName: "CatalogNoActive",
                            titleKey: "Catalog"
                        )
                    }
                
                CartView(viewModel: cartViewModel)
                    .tabItem {
                        TabItemView(
                            imageName: "BasketNoActive",
                            titleKey: "Cart"
                        )
                    }
            }
            .tint(.blueUniversalYP)
            .blur(radius: cartViewModel.isShowingRemoveModal ? 40 : 0)
            .animation(.easeInOut, value: cartViewModel.isShowingRemoveModal)
            
            // Модальное окно удаления nft из корзины
            if cartViewModel.isShowingRemoveModal {
                Color.whiteDynamicYP.opacity(0.05)
                    .ignoresSafeArea()
                    .transition(.opacity)
                
                CartModalView(
                    imageURL: cartViewModel.selectedNft?.imageURL,
                    onTapButtonAction: cartViewModel.closeRemoveModal
                )
                .transition(.scale.combined(with: .opacity))
            }
        }
        .animation(.easeInOut, value: cartViewModel.isShowingRemoveModal)
    }
}

#Preview {
    TabBarView()
}
