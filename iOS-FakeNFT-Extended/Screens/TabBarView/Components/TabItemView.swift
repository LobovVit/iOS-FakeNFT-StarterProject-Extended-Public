import SwiftUI

struct TabItemView: View {
    let imageName: String
    let titleKey: LocalizedStringKey

    var body: some View {
        VStack {
            Image(imageName)
            Text(titleKey)
        }
    }
}
