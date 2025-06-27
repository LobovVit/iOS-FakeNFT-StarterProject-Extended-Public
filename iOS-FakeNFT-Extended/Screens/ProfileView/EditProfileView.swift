//
//  EditProfileView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Vitaly Lobov on 27.06.2025.
//

import SwiftUI
import PhotosUI

struct EditProfileView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: ProfileViewModel
    @State private var selectedPhoto: PhotosPickerItem?
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // MARK: - Avatar
                    avatarView
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .frame(maxWidth: .infinity)
                        .padding(.top, 32)
                    
                    // MARK: - Имя
                    VStack(alignment: .leading, spacing: 8) {
                        Text(LocalizedStringKey("Name"))
                            .font(.headline)
                        TextField("", text: $viewModel.name)
                            .padding(12)
                            .background(Color(UIColor.secondarySystemBackground))
                            .cornerRadius(10)
                    }
                    
                    // MARK: - Описание
                    VStack(alignment: .leading, spacing: 8) {
                        Text(LocalizedStringKey("Description"))
                            .font(.headline)
                        
                        MultilineTextField(text: $viewModel.description)
                            .frame(height: 100)
                    }
                    
                    // MARK: - Сайт
                    VStack(alignment: .leading, spacing: 8) {
                        Text(LocalizedStringKey("Site"))
                            .font(.headline)
                        TextField("", text: $viewModel.website)
                            .padding(12)
                            .background(Color(UIColor.secondarySystemBackground))
                            .cornerRadius(10)
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
                            .foregroundColor(.primary)
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private var avatarView: some View {
        ZStack {
            if let data = viewModel.avatarImageData, let image = UIImage(data: data) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
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
                .font(.caption)
                .foregroundColor(.white)
                .bold()
        }
        .frame(width: 100, height: 100)
        .clipShape(Circle())
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = ProfileViewModel()
        vm.name = "Joaquin Phoenix"
        vm.description = "Дизайнер из Казани, люблю цифровое искусство и бейглы. В моей коллекции уже 100+ NFT, и еще больше — на моём сайте. Открыт к коллаборациям."
        vm.website = "JoaquinPhoenix.com"
        return EditProfileView(viewModel: vm)
    }
}
