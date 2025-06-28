import SwiftUI
import Kingfisher

struct CartCell: View {
    let item: CartItem
    
    // MARK: - Body
    
    var body: some View {
        HStack(spacing: 20) {
            image
            infoSection
            Spacer()
            Image("CartActive")
        }
    }
    
    // MARK: - Content
    
    private var image: some View {
        KFImage(URL(string: item.imageURL))
            .placeholder {
                ProgressView()
            }
            .resizable()
            .scaledToFill()
            .frame(width: 108, height: 108)
            .clipped()
            .cornerRadius(12)
    }
    
    private var infoSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(item.name)
                .font(.system(size: 17, weight: .bold))
                .padding(.bottom, 6)
            
            HStack(spacing: 2) {
                ForEach(0..<5) { index in
                    Image(index < item.rating ? "StarsActive" : "StarsNoActive")
                }
            }
            .padding(.bottom, 14)
            
            Text(String(localized: "Price"))
                .font(.system(size: 13, weight: .regular))
                .padding(.bottom, 4)
            
            Text("\(item.price, specifier: "%.2f") ETH")
                .font(.system(size: 17, weight: .bold))
        }
        .foregroundColor(.blackDynamicYP)
    }
}

#Preview {
    CartCell(item: CartItemMock.data[0])
}
