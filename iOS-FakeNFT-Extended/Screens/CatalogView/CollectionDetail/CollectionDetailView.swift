//
//  CollectionDetailView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Demain Petropavlov on 30.06.2025.
//

import SwiftUI
import Kingfisher

struct CollectionDetailView: View {
    let collection: CollectionDTO
    @StateObject var viewModel: CollectionDetailViewModel

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(spacing: 0) {
            // MARK: - Изображение коллекции с кнопкой Назад
            ZStack(alignment: .topLeading) {
                KFImage(URL(string: collection.cover))
                    .resizable()
                    .frame(height: 310)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .clipped()
                    .ignoresSafeArea()

                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image("BackwardIcon")
                        .foregroundColor(.black)
                        .frame(width: 42, height: 42)
                        .clipShape(Circle())
                        .shadow(radius: 4)
                }
                .padding(.leading, 0)
                .padding(.top, 0)
            }
            .padding(.bottom, -36)

            // MARK: - Информация о коллекции
            VStack(alignment: .leading, spacing: 8) {
                Text(collection.name)
                    .font(.title3).bold()

                HStack(spacing: 4) {
                    Text("Автор коллекции:")
                        .font(.subheadline)
                        .foregroundColor(.black)

                    Text(collection.author)
                        .font(.subheadline)
                        .foregroundColor(.blue)
                }

                Text(collection.description)
                    .font(.body)
                    .foregroundColor(.black)
            }
            .padding(.horizontal, 16)

            // MARK: - NFT Grid
            ScrollView {
                LazyVGrid(
                    columns: Array(repeating: GridItem(.flexible(), spacing: 0), count: 3),
                    spacing: 0
                ) {
                    ForEach(viewModel.displayedNFTs) { nft in
                        NFTCardView(
                            nft: nft,
                            isFavorite: viewModel.isFavorite(for: nft.id),
                            isInCart: viewModel.isInCart(for: nft.id),
                            onFavoriteTap: {
                                viewModel.toggleFavorite(for: nft.id)
                            },
                            onCartTap: {
                                viewModel.toggleCart(for: nft.id)
                            }
                        )
                        .padding(.bottom, 28)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 24)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
    }
}


struct CollectionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let mockNFTs: [NFTItem] = [
            NFTItem(
                id: "1",
                name: "Archie",
                images: ["https://yac-wh-sb-prod-s3-media-07001.storage.yandexcloud.net/media/images/Shutterstock_1166521015.max-2880x1820.format-jpeg.jpg"],
                rating: 4,
                description: "Some cute bunny",
                price: 1.0,
                author: "John Doe"
            ),
            NFTItem(
                id: "2",
                name: "Ruby",
                images: ["https://yac-wh-sb-prod-s3-media-07001.storage.yandexcloud.net/media/images/Shutterstock_1166521015.max-2880x1820.format-jpeg.jpg"],
                rating: 5,
                description: "Magical rabbit",
                price: 1.0,
                author: "John Doe"
            ),
            NFTItem(
                id: "3",
                name: "Nacho",
                images: ["https://yac-wh-sb-prod-s3-media-07001.storage.yandexcloud.net/media/images/Shutterstock_1166521015.max-2880x1820.format-jpeg.jpg"],
                rating: 3,
                description: "Playful dragon",
                price: 1.0,
                author: "John Doe"
            ),
            NFTItem(
                id: "4",
                name: "Nacho",
                images: ["https://yac-wh-sb-prod-s3-media-07001.storage.yandexcloud.net/media/images/Shutterstock_1166521015.max-2880x1820.format-jpeg.jpg"],
                rating: 3,
                description: "Playful dragon",
                price: 1.0,
                author: "John Doe"
            )
        ]

        let mockCollection = CollectionDTO(
            id: "c1",
            name: "Peach",
            cover: "https://yac-wh-sb-prod-s3-media-07001.storage.yandexcloud.net/media/images/Shutterstock_1166521015.max-2880x1820.format-jpeg.jpg",
            description: "Персиковый — как облака над закатным солнцем в океане. В этой коллекции совмещены трогательная нежность и живая игривость сказочных эфириных зверей.",
            author: "John Doe",
            nfts: ["1", "2", "3", "4"]
        )

        CollectionDetailView(
            collection: mockCollection,
            viewModel: CollectionDetailViewModel(nfts: mockNFTs)
        )
    }
}
