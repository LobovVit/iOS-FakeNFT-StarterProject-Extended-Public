//
//  AvatarEditView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Vitaly Lobov on 07.07.2025.
//

import SwiftUI

struct AvatarEditView: View {
    @Binding var avatarUrl: String?
    @Environment(\.dismiss) private var dismiss
    @State private var draftUrl: String = ""

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                TextField("Image URL", text: $draftUrl)
                    .textFieldStyle(.roundedBorder)
                    .onAppear {
                        draftUrl = avatarUrl ?? ""
                    }

                if let url = URL(string: draftUrl) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    } placeholder: {
                        ProgressView()
                    }
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Edit Avatar")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        avatarUrl = draftUrl
                        dismiss()
                    }
                }
            }
        }
    }
}
