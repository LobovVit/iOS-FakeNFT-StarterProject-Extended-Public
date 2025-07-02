//
//  FavoriteNFTCardView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Vitaly Lobov on 30.06.2025.
//

import SwiftUI

struct FavoriteNFTCardView: View {
    let nft: NFTModel

    var body: some View {
        HStack(spacing: 12) {
            ZStack(alignment: .topTrailing) {
                if let url = URL(string: nft.images.first ?? "") {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .aspectRatio(1, contentMode: .fill)
                    } placeholder: {
                        Color.gray.opacity(0.2)
                    }
                    .frame(width: 80, height: 80)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }

                Image(systemName: "heart.fill")
                    .foregroundColor(.red)
                    .padding(4)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(nft.name)
                    .font(Fonts.bodyBold)
                    .lineLimit(1)

                RatingView(rating: nft.rating)

                Text("\(String(format: "%.2f", nft.price)) ETH")
                    .font(Fonts.bodyRegular)
            }

            Spacer()
        }
        .padding(.vertical, 4)
    }
}

struct FavoriteNFTCardView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteNFTCardView(nft: MockData.nfts.first!)
    }
}
