//
//  MockProfileView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Vitaly Lobov on 26.06.2025.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewModel()
    @State private var isEditing = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    HStack(alignment: .top, spacing: 16) {
                        avatarView

                        VStack(alignment: .leading, spacing: 8) {
                            Text(viewModel.name.isEmpty ? "Имя не указано" : viewModel.name)
                                .font(.title3)
                                .bold()

                            if !viewModel.website.isEmpty, let url = URL(string: viewModel.website) {
                                Link(viewModel.website, destination: url)
                                    .font(.footnote)
                                    .foregroundColor(.blue)
                            }
                        }
                        Spacer()
                    }
                    .padding(.horizontal)

                    if !viewModel.description.isEmpty {
                        Text(viewModel.description)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .padding(.horizontal)
                    }

                    VStack(spacing: 1) {
                        NavigationLink(destination: Text("Мои NFT")) {
                            HStack {
                                Text("Мои NFT")
                                    .foregroundColor(.primary)
                                Spacer()
                                Text("(112)")
                                    .foregroundColor(.secondary)
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                            }
                            .padding()
                        }

                        Divider()

                        NavigationLink(destination: Text("Избранные NFT")) {
                            HStack {
                                Text("Избранные NFT")
                                    .foregroundColor(.primary)
                                Spacer()
                                Text("(11)")
                                    .foregroundColor(.secondary)
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                            }
                            .padding()
                        }

                        Divider()

                        NavigationLink(destination: Text("О разработчике")) {
                            HStack {
                                Text("О разработчике")
                                    .foregroundColor(.primary)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                            }
                            .padding()
                        }
                    }
                    .background(Color(.systemBackground))
                    .cornerRadius(10)
                    .padding(.horizontal)
                }
                .padding(.top)
            }
            .navigationTitle("Профиль")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isEditing = true
                    }) {
                        Image(systemName: "square.and.pencil")
                            .foregroundColor(Color.primary)
                    }
                }
            }
            .sheet(isPresented: $isEditing) {
                EditProfileView(viewModel: viewModel)
            }
        }
    }

    private var avatarView: some View {
        Group {
            if let data = viewModel.avatarImageData, let image = UIImage(data: data) {
                Image(uiImage: image)
                    .resizable()
            } else {
                Image(systemName: "person.crop.circle")
                    .resizable()
            }
        }
        .frame(width: 72, height: 72)
        .clipShape(Circle())
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ProfileViewModel()
        viewModel.name = "Joaquin Phoenix"
        viewModel.description = "Дизайнер из Казани, люблю цифровое искусство и бейглы. В моей коллекции уже 100+ NFT, и еще больше — на моём сайте. Открыт к коллаборациям."
        viewModel.website = "JoaquinPhoenix.com"
        return ProfileView(viewModel: viewModel)
    }
}
