//
//  ProfileView.swift
//
//  iOS-FakeNFT-Extended
//
//  Created by Vitaly Lobov on 26.06.2025.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewModel()
    @State private var isEditing = false
    @State private var showWebView = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    avatarAndNameView
                        .padding(.top, 24)

                    if !viewModel.description.isEmpty {
                        Text(viewModel.description)
                            .font(Fonts.smallRegular)
                            .foregroundColor(.primary)
                            .multilineTextAlignment(.leading)
                            .padding(.horizontal, 20)
                    }

                    if !viewModel.website.isEmpty {
                        Button(action: { showWebView = true }) {
                            Text(viewModel.website)
                                .font(Fonts.mediumRegular)
                                .foregroundColor(.blue)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 20)
                        }
                    }

                    VStack(spacing: 0) {
                        NavigationLink(destination: MyNFTView()) {
                            profileRow(title: "Мои NFT", value: "(112)")
                        }

                        NavigationLink(destination: FavoritesNFTView()) {
                            profileRow(title: "Избранные NFT", value: "(\(viewModel.favoritesCount))")
                        }

                        Button {
                            showWebView = true
                        } label: {
                            profileRow(title: "О разработчике", value: nil)
                        }
                    }
                    .padding(.top, 32)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { isEditing = true }) {
                        Image(systemName: "square.and.pencil")
                            .resizable()
                            .frame(width: 26, height: 26)
                            .foregroundStyle(Color.primary)
                    }
                }
            }
            .sheet(isPresented: $isEditing) {
                EditProfileView(viewModel: viewModel)
            }
            .sheet(isPresented: $showWebView) {
                if let url = viewModel.validWebsiteURL {
                    WebViewScreen(url: url)
                }
            }
        }
    }

    private var avatarAndNameView: some View {
        HStack(alignment: .center, spacing: 16) {
            avatarView

            VStack(alignment: .leading, spacing: 4) {
                Text(viewModel.name.isEmpty ? String(localized: "Name not specified") : viewModel.name)
                    .font(Fonts.titleBold)
                    .foregroundColor(.primary)
            }

            Spacer()
        }
        .padding(.horizontal, 20)
    }

    private var avatarView: some View {
        Group {
            if let data = viewModel.avatarImageData, let image = UIImage(data: data) {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else {
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
        .frame(width: 70, height: 70)
        .clipShape(Circle())
    }

    @ViewBuilder
    private func profileRow(title: String, value: String?) -> some View {
        HStack {
            Text(LocalizedStringKey(title))
                .font(Fonts.bodyBold)
                .foregroundColor(.primary)

            if let value = value {
                Text(value)
                    .font(Fonts.bodyBold)
                    .foregroundColor(.primary)
            }
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.primary)
        }
        .padding(.vertical, 14)
        .padding(.horizontal, 20)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ProfileViewModel()
        viewModel.name = "Joaquin Phoenix"
        viewModel.description = "Дизайнер из Казани, люблю цифровое искусство и бейглы. В моей коллекции уже 100+ NFT, и еще больше — на моём сайте. Открыт к коллаборациям."
        viewModel.website = "https://apple.com"
        return ProfileView(viewModel: viewModel)
    }
}
