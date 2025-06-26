import SwiftUI
import Kingfisher

struct CartCell: View {
    let item: CartItem
    
    var body: some View {
        HStack(spacing: 20) {
            image
            infoSection
            
            Spacer()
            // TODO: Добавить кастомную иконку
            Image(systemName: "trash")
                .foregroundColor(.gray)
        }
    }
    
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
        VStack(alignment: .leading) {
            Text(item.name)
                .font(.system(size: 17, weight: .bold))
                .padding(.bottom, 4)
            
            HStack(spacing: 2) {
                ForEach(0..<5) { index in
                    // TODO: Добавить кастомные иконки
                    Image(systemName: index < item.rating ? "star.fill" : "star")
                        .foregroundColor(index < item.rating ? .yellow : .gray)
                }
            }
            .padding(.bottom, 12)
            
            Text(String(localized: "Price"))
                .font(.system(size: 13, weight: .regular))
                .padding(.bottom, 2)
            
            Text("\(item.price, specifier: "%.2f") ETH")
                .font(.system(size: 17, weight: .bold))
        }
        // TODO: Добавить кастомный цвет
        .foregroundColor(.black)
    }
}

#Preview {
    CartCell(item: CartItemMock.data[0])
}
