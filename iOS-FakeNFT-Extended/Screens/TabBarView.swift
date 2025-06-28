import SwiftUI

struct TabBarView: View {
    var body: some View {
        // TODO: Далее заменить иконки для таба и цвет обводки
        TabView {
            ProfileView()
                .tabItem {
                    Label(String(localized: "Profile"), systemImage: "person.circle")
                }
            
            CatalogView()
                .tabItem {
                    Label(String(localized: "Catalog"), systemImage: "square.grid.2x2")
                }
            
            CartView()
                .tabItem {
                    Label(String(localized: "Cart"), systemImage: "cart")
                }
        }
    }
}

#Preview {
    TabBarView()
}
