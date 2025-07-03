//
//  NFTCardView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Vitaly Lobov on 30.06.2025.
//

import SwiftUI

struct NFTCardView: View {
    let nft: NFTModel

    var body: some View {
        HStack(spacing: 16) {
            if let url = URL(string: nft.images.first ?? "") {
                AsyncImage(url: url) { image in
                    image.resizable().aspectRatio(contentMode: .fill)
                } placeholder: {
                    Color.gray
                }
                .frame(width: 108, height: 108)
                .cornerRadius(12)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(nft.name)
                    .font(Fonts.bodyBold)
                RatingView(rating: nft.rating)
                Text("от \(nft.author)")
                    .font(Fonts.tinyMedium)
                    .foregroundColor(.gray)
            }

            Spacer()

            VStack(alignment: .trailing) {
                Text(String(localized: "Price"))
                    .font(Fonts.smallRegular)
                    .foregroundColor(.gray)
                Text("\(String(format: "%.2f", nft.price)) ETH")
                    .font(Fonts.bodyBold)
            }
        }
        .padding(.vertical, 8)
    }
}

struct NFTCardView_Previews: PreviewProvider {
    static var previews: some View {
        NFTCardView(nft: MockData.nfts.first!)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
