//
//  EditProfileView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Vitaly Lobov on 27.06.2025.
//

import SwiftUI

struct EditProfileView: View {
    @ObservedObject var viewModel: ProfileViewModel
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            Form {
                Section {
                    HStack {
                        Spacer()
                        VStack {
                            Image(systemName: "person.crop.circle")
                                .resizable()
                                .frame(width: 80, height: 80)
                                .clipShape(Circle())
                                .padding(.bottom, 4)

                            Button("Сменить фото") {
                                // TODO: add image picker logic
                            }
                            .font(.caption)
                        }
                        Spacer()
                    }
                }

                Section(header: Text("Имя")) {
                    TextField("Имя", text: $viewModel.name)
                }

                Section(header: Text("Описание")) {
                    TextEditor(text: $viewModel.description)
                        .frame(height: 120)
                }

                Section(header: Text("Сайт")) {
                    TextField("example.com", text: $viewModel.website)
                        .keyboardType(.URL)
                        .autocapitalization(.none)
                }
            }
            .navigationTitle("Редактировать")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Готово") {
                        viewModel.saveProfile()
                        dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Отмена") {
                        dismiss()
                    }
                }
            }
        }
    }
}
