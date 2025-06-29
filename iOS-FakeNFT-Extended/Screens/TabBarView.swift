import SwiftUI

struct TabBarView: View {
    @StateObject var cartViewModel = CartViewModel()
    
    var body: some View {
        // TODO: Далее заменить иконки для таба и цвет обводки
        ZStack {
            TabView {
                ProfileView()
                    .tabItem {
                        Label(String(localized: "Profile"), systemImage: "person.circle")
                    }
                
                CatalogView()
                    .tabItem {
                        Label(String(localized: "Catalog"), systemImage: "square.grid.2x2")
                    }
                
                CartView(viewModel: cartViewModel)
                    .tabItem {
                        Label(String(localized: "Cart"), systemImage: "cart")
                    }
            }
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
