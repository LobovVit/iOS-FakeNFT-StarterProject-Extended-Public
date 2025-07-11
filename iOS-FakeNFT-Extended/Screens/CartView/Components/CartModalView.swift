import SwiftUI
import Kingfisher

struct CartModalView: View {
    let imageURL: String?
    let onTapRemoveAction: () -> Void
    let onTapReturnAction: () -> Void
    
    // MARK: - Body
    
    var body: some View {
        VStack(spacing: 12) {
            nftImage
            modalTitle
            modalButtons
        }
        .frame(maxWidth: CartModalViewConstants.bodyWidth)
    }
    
    // MARK: - Content
    
    private var nftImage: some View {
        AsyncImage(url: URL(string: imageURL ?? "")) { image in
            image
                .resizable()
                .scaledToFill()
        } placeholder: {
            ProgressView()
                .tint(.gray)
        }
        .frame(width: CartModalViewConstants.imageSize, height: CartModalViewConstants.imageSize)
        .clipped()
        .cornerRadius(CartModalViewConstants.imageCornerRadius)
    }
    
    private var modalTitle: some View {
        Text(String(localized: "Are you sure you want to\nremove this item from your cart? "))
            .font(Fonts.smallRegular)
            .foregroundColor(.blackDynamicYP)
            .multilineTextAlignment(.center)
            .padding(.bottom, 8)
    }
    
    private var modalButtons: some View {
        HStack(spacing: 8) {
            CartModalActionButton(
                title: String(localized: "Remove"),
                titleColor: .redUniversalYP
            ) {
                onTapRemoveAction()
            }
            
            CartModalActionButton(
                title: String(localized: "Return"),
                titleColor: .whiteDynamicYP
            ) {
                onTapReturnAction()
            }
        }
    }
}

#Preview {
    CartModalView(
        imageURL: "https://loremflickr.com/600/600",
        onTapRemoveAction: {},
        onTapReturnAction: {}
    )
}
