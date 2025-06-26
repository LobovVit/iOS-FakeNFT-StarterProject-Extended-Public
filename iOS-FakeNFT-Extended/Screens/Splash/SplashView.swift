//
//  SplashView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Vitaly Lobov on 26.06.2025.
//

import SwiftUI

struct SplashView: View {
    @State private var showMain = false

    var body: some View {
        ZStack {
            Color(.systemBackground).ignoresSafeArea()

            if let logo = UIImage(named: "logo") {
                Image(uiImage: logo)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
            } else {
                Rectangle()
                    .fill(Color.primary)
                    .frame(width: 100, height: 100)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                showMain = true
            }
        }
        .fullScreenCover(isPresented: $showMain) {
            ContentView()
        }
    }
}
