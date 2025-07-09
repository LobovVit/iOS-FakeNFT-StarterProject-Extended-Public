import SwiftUI

struct CurrencyCell: View {
    let currency: Currency
    let isSelected: Bool
    
    private enum Constants {
        static let imageSize: CGFloat = 36
        static let imageCornerRadius: CGFloat = 6
    }
    
    // MARK: - Body
    
    var body: some View {
        HStack(spacing: 4) {
            image
            text
            Spacer()
        }
        .padding(.vertical, 5)
        .padding(.horizontal, 12)
        .background(Color(UIColor.lightGreyDynamicYP))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(isSelected ? .blackDynamicYP : .clear, lineWidth: 1)
        )
    }
    
    // MARK: - Content
    
    private var image: some View {
        AsyncImage(url: URL(string: currency.imageURL)) { image in
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
    
    private var text: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(currency.title)
                .font(Fonts.smallRegular)
                .foregroundColor(.blackDynamicYP)
            Text(currency.name)
                .font(Fonts.smallRegular)
                .foregroundColor(.greenUniversalYP)
        }
    }
}

#Preview {
    CurrencyCell(currency: CurrencyMock.data[0], isSelected: false)
}
