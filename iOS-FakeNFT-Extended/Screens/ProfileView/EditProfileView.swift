//
//  EditProfileView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Vitaly Lobov on 27.06.2025.
//

//
//  EditProfileView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Vitaly Lobov on 27.06.2025.
//

import SwiftUI

struct EditProfileView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: ProfileViewModel
    @State private var isAvatarEditPresented = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // MARK: - Avatar
                    Button(action: {
                        isAvatarEditPresented = true
                    }) {
                        avatarView
                            .frame(width: 70, height: 70)
                            .clipShape(Circle())
                            .frame(maxWidth: .infinity)
                            .padding(.top, 24)
                    }
                    .sheet(isPresented: $isAvatarEditPresented) {
                        AvatarEditView(avatarUrl: $viewModel.profile.avatar)
                    }
                    
                    // MARK: - Имя
                    VStack(alignment: .leading, spacing: 8) {
                        Text(LocalizedStringKey("Name"))
                            .font(Fonts.titleBold)
                        TextField("", text: $viewModel.profile.name)
                            .font(Fonts.bodyRegular)
                            .padding(12)
                            .background(Color(UIColor.secondarySystemBackground))
                            .cornerRadius(10)
                    }
                    
                    // MARK: - Описание
                    VStack(alignment: .leading, spacing: 8) {
                        Text(LocalizedStringKey("Description"))
                            .font(Fonts.titleBold)
                        
                        MultilineTextField(text: $viewModel.profile.description)
                            .font(Fonts.bodyRegular)
                            .multilineTextAlignment(.leading)
                            .frame(height: 120)
                    }
                    
                    // MARK: - Сайт
                    VStack(alignment: .leading, spacing: 8) {
                        Text(LocalizedStringKey("Site"))
                            .font(Fonts.titleBold)
                        TextField("", text: $viewModel.profile.website)
                            .font(Fonts.bodyRegular)
                            .padding(12)
                            .background(Color(UIColor.secondarySystemBackground))
                            .cornerRadius(10)
                    }
                    
                    Spacer()
                    // MARK: - Save Button
                    if viewModel.hasProfileChanges {
                        Button(action: {
                            Task {
                                await viewModel.saveProfile()
                                dismiss()
                            }
                        }) {
                            Text(LocalizedStringKey("Save"))
                                .font(Fonts.bodyBold)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.accentColor)
                                .cornerRadius(12)
                        }
                        .padding(.top, 12)
                    }
                    Spacer()
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: dismiss.callAsFunction) {
                        Image(systemName: "xmark")
                            .resizable()
                            .frame(width: 14, height: 14)
                            .foregroundColor(.primary)
                    }
                    .padding(.top, 32)
                }
            }
            .onAppear {
                viewModel.prepareForEditing()
            }
        }
    }
    
    @ViewBuilder
    private var avatarView: some View {
        ZStack {
            if let urlString = viewModel.profile.avatar,
               let url = URL(string: urlString) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    ZStack {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.gray.opacity(0.5))
                        ProgressView()
                            .tint(.gray)
                    }
                }
            } else {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.gray.opacity(0.5))
            }
            
            Rectangle()
                .foregroundColor(.black)
                .opacity(0.3)
                .clipShape(Circle())
            
            Text(LocalizedStringKey("Change photo"))
                .font(Fonts.tinyMedium)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .lineLimit(2)
        }
        .frame(width: 70, height: 70)
        .clipShape(Circle())
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = ProfileViewModel()
        vm.profile.name = "Joaquin Phoenix"
        vm.profile.description = "Дизайнер из Казани, люблю цифровое искусство и бейглы. В моей коллекции уже 100+ NFT, и еще больше — на моём сайте. Открыт к коллаборациям."
        vm.profile.website = "JoaquinPhoenix.com"
        vm.profile.avatar = "https://i.imgur.com/1QdE3Ue.jpeg"
        return EditProfileView(viewModel: vm)
    }
}
