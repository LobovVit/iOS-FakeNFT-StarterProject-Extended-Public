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
    @State private var isPresentingWebView = false

    var body: some View {
        ZStack {
            Color(.whiteDynamicYP)
                .ignoresSafeArea()

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
                            .renderingMode(.template)
                            .foregroundColor(.blackDynamicYP)
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
                        .font(Fonts.bodyBold)
                        .foregroundColor(.blackDynamicYP)

                    HStack(spacing: 4) {
                        Text(String(localized: "The author of the collection") + ":")
                            .font(Fonts.mediumRegular)
                            .foregroundColor(.blackDynamicYP)

                        Button(action: {
                            isPresentingWebView = true
                        }) {
                            Text(collection.author)
                                .font(Fonts.mediumRegular)
                                .foregroundColor(.blue)
                        }
                    }

                    Text(collection.description)
                        .font(Fonts.mediumRegular)
                        .foregroundColor(.blackDynamicYP)
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
            .fullScreenCover(isPresented: $isPresentingWebView) {
                AuthorWebView(urlString: ExternalLinks.practicumCourse)
            }
        }
    }
}

enum ExternalLinks {
    static let practicumCourse = "https://practicum.yandex.com/ios-developer/?utm_source=google&utm_medium=cpc&utm_campaign=Gog_Sch_COM_Common_Unde_b2c_Dynamic_Regular_1&utm_content=nt_g%3Apl_%3Acid_22149138686%3Agid_174072568215%3Akw_%3Atid_dsa-2420994995274%3Acrid_733586225513%3Aadp_%3Ad_c%3Adm_%3Alim_%3Alpm_1010561&utm_term=&gad_source=1&gad_campaignid=22149138686&gbraid=0AAAAAqA9dPEPIHIWmECc47DgEn6_Aly49&gclid=Cj0KCQjw1JjDBhDjARIsABlM2SsQjE7-LpeW6DkQ9QeBwMuyo2IuT8IgjWbKyozqQPyXJE13GGG5KvMaAj7WEALw_wcB"
}

// MARK: - Preview
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
