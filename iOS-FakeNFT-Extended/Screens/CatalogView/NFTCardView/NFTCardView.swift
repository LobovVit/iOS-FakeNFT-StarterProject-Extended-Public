//
//  NFTCardView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Demain Petropavlov on 30.06.2025.
//

import SwiftUI
import Kingfisher

struct NFTCardView: View {
    let nft: NFTItem
    let isFavorite: Bool
    let isInCart: Bool
    let onFavoriteTap: () -> Void
    let onCartTap: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .topTrailing) {
                if let imageUrlString = nft.images.first,
                   let url = URL(string: imageUrlString) {
                    KFImage(url)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 108, height: 108)
                        .clipped()
                        .cornerRadius(12)
                } else {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 108, height: 108)
                        .cornerRadius(12)
                }

                Button(action: onFavoriteTap) {
                    Image(isFavorite ? "FavouritesActive" : "FavouritesNoActive")
                        .resizable()
                        .frame(width: 40, height: 40)
                }
            }

            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 2) {
                    ForEach(0..<5) { index in
                        Image(index < nft.rating ? "StarsActive" : "StarsNoActive")
                            .resizable()
                            .frame(width: 12, height: 12)
                    }
                }

                HStack(alignment: .center) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(nft.name)
                            .font(Fonts.bodyBold)
                            .lineLimit(1)

                        Text("\(String(format: "%.2f", nft.price)) ETH")
                            .font(Fonts.tinyMedium)
                    }

                    Spacer()

                    Button(action: onCartTap) {
                        Image(isInCart ? "CartActive" : "CartNoActive")
                            .resizable()
                            .frame(width: 40, height: 40)
                    }
                }
                .padding(.top, 5)
            }
            .frame(width: 108)
        }
        .frame(width: 108)
    }
}

//MARK: - Preview
struct NFTCardView_Previews: PreviewProvider {
    static var previews: some View {
        let mockNFT = NFTItem(
            id: "nft1",
            name: "Archie",
            images: ["https://yac-wh-sb-prod-s3-media-07001.storage.yandexcloud.net/media/images/Shutterstock_1166521015.max-2880x1820.format-jpeg.jpg"],
            rating: 2,
            description: "Cute pink thing",
            price: 1.0,
            author: "Author"
        )

        return NFTCardView(
            nft: mockNFT,
            isFavorite: true,
            isInCart: false,
            onFavoriteTap: { print("Tapped favorite") },
            onCartTap: { print("Tapped cart") }
        )
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
