import SwiftUI

// Стили для NavigationStack
struct CustomNavStyleModifier: ViewModifier {
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .whiteDynamicYP
        appearance.shadowColor = .clear
        
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.blackDynamicYP,
            .font: UIFont.systemFont(ofSize: 17, weight: .bold)
        ]
        
        // Убираем текст "Back", оставляем только стрелку
        let backButtonAppearance = UIBarButtonItemAppearance()
        backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear]
        
        appearance.backButtonAppearance = backButtonAppearance
        
        // Устанавливаем иконку "назад" и её цвет
        let backImage = UIImage(systemName: "chevron.backward")?.withTintColor(.blackDynamicYP, renderingMode: .alwaysOriginal)
        appearance.setBackIndicatorImage(backImage, transitionMaskImage: backImage)
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    func body(content: Content) -> some View {
        content
    }
}
