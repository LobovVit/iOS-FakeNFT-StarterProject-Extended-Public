import SwiftUI

struct CartModalActionButton: View {
    let title: String
    let titleColor: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            withAnimation {
                action()
            }
        }) {
            Text(title)
                .foregroundColor(titleColor)
                .font(Fonts.bodyRegular)
                .frame(maxWidth: .infinity)
                .frame(height: 44)
                .background(Color.blackDynamicYP)
                .cornerRadius(12)
        }
    }
}

#Preview {
    CartModalActionButton(
        title: String(localized: "Return"),
        titleColor: .whiteDynamicYP,
        action: {}
    )
}
