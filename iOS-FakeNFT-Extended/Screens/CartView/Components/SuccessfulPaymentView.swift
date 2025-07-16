import SwiftUI

struct SuccessfulPaymentView: View {
    let onReturnToCart: () -> Void
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            Spacer()
            image
            title
            Spacer()
            button
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
    
    // MARK: - Content
    
    private var image: some View {
        Image("SuccessfulNft")
            .resizable()
            .scaledToFit()
            .frame(
                width: SuccessfulPaymentViewConstants.imageSize,
                height: SuccessfulPaymentViewConstants.imageSize
            )
            .padding(.bottom, 20)
    }
    
    private var title: some View {
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
        .frame(height: SuccessfulPaymentViewConstants.buttonHeight)
        .background(.blackDynamicYP)
        .cornerRadius(SuccessfulPaymentViewConstants.buttonCornerRadius)
        .padding(16)
    }
    
}

#Preview {
    SuccessfulPaymentView(onReturnToCart: {})
}
