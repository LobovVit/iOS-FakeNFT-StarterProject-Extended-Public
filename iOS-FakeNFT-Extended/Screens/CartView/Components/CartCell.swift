import SwiftUI
import Kingfisher

struct CartCell: View {
    private enum Constants {
        static let imageSize: CGFloat = 108
        static let imageCornerRadius: CGFloat = 12
    }
    
    let item: CartItem
    let onRemove: () -> Void
    
    // MARK: - Body
    
    var body: some View {
        HStack(spacing: 20) {
            image
            infoSection
            Spacer()
            removeIcon
        }
    }
    
    // MARK: - Content
    
    private var image: some View {
        AsyncImage(url: URL(string: item.images[0])) { image in
            image
                .resizable()
                .scaledToFill()
        } placeholder: {
            ProgressView()
                .tint(.gray)
        }
        .frame(width: Constants.imageSize, height: Constants.imageSize)
        .clipped()
        .cornerRadius(Constants.imageCornerRadius)
    }
    
    private var infoSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(item.name)
                .font(Fonts.bodyBold)
                .padding(.bottom, 6)
            
            HStack(spacing: 2) {
                ForEach(0..<5) { index in
                    Image(index < item.rating ? "StarsActive" : "StarsNoActive")
                }
            }
            .padding(.bottom, 14)
            
            Text(String(localized: "Price"))
                .font(Fonts.smallRegular)
                .padding(.bottom, 4)
            
            Text("\(item.price, specifier: "%.2f") ETH")
                .font(Fonts.bodyBold)
        }
        .foregroundColor(.blackDynamicYP)
    }
    
    private var removeIcon: some View {
        Image("CartActive")
            .onTapGesture {
                onRemove()
            }
    }
}

#Preview {
    CartCell(item: CartItemMock.data[0], onRemove: {})
}
