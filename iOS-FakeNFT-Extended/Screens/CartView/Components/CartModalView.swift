import SwiftUI
import Kingfisher

struct CartModalView: View {
    private enum Constants {
        static let imageSize: CGFloat = 108
        static let imageCornerRadius: CGFloat = 12
        static let bodyWidth: CGFloat = 262
    }
    
    let imageURL: String?
    let onTapButtonAction: () -> Void
    
    // MARK: - Body
    
    var body: some View {
        VStack(spacing: 12) {
            nftImage
            modalTitle
            modalButtons
        }
        .frame(maxWidth: Constants.bodyWidth)
    }
    
    // MARK: - Content
    
    private var nftImage: some View {
        AsyncImage(url: URL(string: imageURL ?? "")) { image in
            image
                .resizable()
                .scaledToFill()
        } placeholder: {
            ProgressView()
        }
        .frame(width: Constants.imageSize, height: Constants.imageSize)
        .clipped()
        .cornerRadius(Constants.imageCornerRadius)
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
                onTapButtonAction()
                // TODO: добавить логику удаления nft
            }
            
            CartModalActionButton(
                title: String(localized: "Return"),
                titleColor: .whiteDynamicYP
            ) {
                onTapButtonAction()
            }
        }
    }
}

#Preview {
    CartModalView(
        imageURL: "https://loremflickr.com/600/600",
        onTapButtonAction: {}
    )
}
