import SwiftUI

struct SuccessfulPaymentView: View {
    private enum Constants {
        static let imageSize: CGFloat = 278
        static let buttonHeight: CGFloat = 60
        static let buttonCornerRadius: CGFloat = 16
    }
    
    let onReturnToCart: () -> Void
    
    var body: some View {
        VStack {
            Spacer()
            image
            text
            Spacer()
            button
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
    
    private var image: some View {
        Image("SuccessfulNft")
            .resizable()
            .scaledToFit()
            .frame(width: Constants.imageSize, height: Constants.imageSize)
            .padding(.bottom, 20)
    }
    
    private var text: some View {
        Text(String(localized: "Success! Payment completed, congratulations on your purchase!"))
            .font(Fonts.titleBold)
            .foregroundColor(.blackDynamicYP)
            .padding(.horizontal, 36)
            .multilineTextAlignment(.center)
    }
    
    private var button: some View {
        Button(String(localized: "Return to cart")) {
            onReturnToCart()
        }
        .font(Fonts.bodyBold)
        .foregroundColor(.whiteDynamicYP)
        .frame(maxWidth: .infinity)
        .frame(height: Constants.buttonHeight)
        .background(.blackDynamicYP)
        .cornerRadius(Constants.buttonCornerRadius)
        .padding(16)
    }
    
}

#Preview {
    SuccessfulPaymentView(onReturnToCart: {})
}
