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

                Image("FavouritesActive")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.red)
                    .offset(x: 0, y: 0)
            }

            VStack(alignment: .leading, spacing: 0) {
                //Рейтинг
                HStack(spacing: 2) {
                    ForEach(0..<5) { index in
                        Image(index < nft.rating ? "StarsActive" : "StarsNoActive")
                            .resizable()
                            .frame(width: 12, height: 12)
                            .foregroundColor(index < nft.rating ? .yellow : .gray)
                    }
                }

                //Название + Цена + Корзина
                HStack(alignment: .center) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(nft.name)
                            .font(Fonts.bodyBold)
                            .lineLimit(1)

                        Text("\(String(format: "%.2f", nft.price)) ETH")
                            .font(Fonts.tinyMedium)
                    }

                    Spacer()

                    Image("CartNoActive")
                        .resizable()
                        .frame(width: 40, height: 40)
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

        return NFTCardView(nft: mockNFT)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
