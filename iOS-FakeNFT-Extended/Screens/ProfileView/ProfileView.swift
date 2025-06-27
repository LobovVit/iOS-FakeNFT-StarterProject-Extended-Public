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
                    
                    // MARK: - Header
                    HStack(alignment: .top, spacing: 16) {
                        avatarView
                            .frame(width: 72, height: 72)
                        
                        VStack(alignment: .leading) {
                            Text(viewModel.name.isEmpty
                                 ? String(localized: "Name not specified")
                                 : viewModel.name)
                            .font(.title3)
                            .bold()
                            .padding(.vertical)
                        }
                    }
                    .padding(.horizontal)
                    
                    // MARK: - Description
                    if !viewModel.description.isEmpty {
                        Text(viewModel.description)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .padding(.horizontal)
                    }
                    
                    // MARK: - Site
                    if !viewModel.website.isEmpty,
                       let url = URL(string: viewModel.website) {
                        Link(viewModel.website, destination: url)
                            .font(.footnote)
                            .foregroundColor(.blue)
                            .padding(.horizontal)
                    }
                    
                    // MARK: - Options
                    VStack(spacing: 1) {
                        profileRow(title: "My NFTs", value: "(112)")
                        Divider()
                        profileRow(title: "Featured NFTs", value: "(11)")
                        Divider()
                        profileRow(title: "About the developer", value: nil)
                    }
                    .background(Color(.systemBackground))
                    .cornerRadius(10)
                    .padding(.horizontal)
                }
                .padding(.top)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isEditing = true
                    }) {
                        Image(systemName: "square.and.pencil")
                            .foregroundColor(.primary)
                    }
                }
            }
            .sheet(isPresented: $isEditing) {
                EditProfileView(viewModel: viewModel)
            }
        }
    }
    
    // MARK: - Avatar
    private var avatarView: some View {
        Group {
            if let data = viewModel.avatarImageData,
               let image = UIImage(data: data) {
                Image(uiImage: image)
                    .resizable()
            } else {
                Image(systemName: "person.crop.circle")
                    .resizable()
            }
        }
        .aspectRatio(contentMode: .fill)
        .clipShape(Circle())
    }
    
    // MARK: - Row Builder
    @ViewBuilder
    private func profileRow(title: String, value: String?) -> some View {
        NavigationLink(destination: Text(LocalizedStringKey(title))) {
            HStack {
                Text(LocalizedStringKey(title))
                    .foregroundColor(.primary)
                if let value = value {
                    Text(value)
                        .foregroundColor(.primary)
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.primary)
            }
            .padding()
        }
    }
}

// MARK: - Preview
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ProfileViewModel()
        viewModel.name = "Joaquin Phoenix"
        viewModel.description = "Дизайнер из Казани, люблю цифровое искусство и бейглы. В моей коллекции уже 100+ NFT, и еще больше — на моём сайте. Открыт к коллаборациям."
        viewModel.website = "JoaquinPhoenix.com"
        return ProfileView(viewModel: viewModel)
    }
}
