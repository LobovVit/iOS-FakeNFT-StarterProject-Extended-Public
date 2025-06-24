import SwiftUI

struct TabBarView: View {
    var body: some View {
        // TODO: Далее заменить иконки для таба, локализованный текст и цвет обводки
        TabView {
            Text("Профиль")
                .tabItem {
                    Label("Профиль", systemImage: "person.circle")
                }
            
            Text("Каталог")
                .tabItem {
                    Label("Каталог", systemImage: "square.grid.2x2")
                }
            
            Text("Корзина")
                .tabItem {
                    Label("Корзина", systemImage: "cart")
                }
        }
    }
}

#Preview {
    TabBarView()
}
