import SwiftUI

struct TabBarView: View {
    var body: some View {
        // TODO: Далее заменить иконки для таба и цвет обводки
        TabView {
            Text(String(localized: "Profile"))
                .tabItem {
                    Label(String(localized: "Profile"), systemImage: "person.circle")
                }
            
            Text(String(localized: "Catalog"))
                .tabItem {
                    Label(String(localized: "Catalog"), systemImage: "square.grid.2x2")
                }
            
            Text(String(localized: "Cart"))
                .tabItem {
                    Label(String(localized: "Cart"), systemImage: "cart")
                }
        }
    }
}

#Preview {
    TabBarView()
}
