//
//  AuthorWebView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Demain Petropavlov on 03.07.2025.
//

import SwiftUI

struct AuthorWebView: View {
    let urlString: String
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image("BackwardIcon")
                        .font(.system(size: 24, weight: .medium))
                        .foregroundColor(.black)
                        .padding(.top, 9)
                        .padding(.leading, 9)
                        .padding(.bottom, 9)
                }
                Spacer()
            }

            WebView(url: URL(string: urlString))
                .edgesIgnoringSafeArea(.bottom)
        }
        .navigationBarBackButtonHidden(true)
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        AuthorWebView(urlString: "https://practicum.yandex.com/ios-developer/?utm_source=google&utm_medium=cpc&utm_campaign=Gog_Sch_COM_Common_Unde_b2c_Dynamic_Regular_1&utm_content=nt_g%3Apl_%3Acid_22149138686%3Agid_174072568215%3Akw_%3Atid_dsa-2420994995274%3Acrid_733586225513%3Aadp_%3Ad_c%3Adm_%3Alim_%3Alpm_1010561&utm_term=&gad_source=1&gad_campaignid=22149138686&gbraid=0AAAAAqA9dPEPIHIWmECc47DgEn6_Aly49&gclid=Cj0KCQjw1JjDBhDjARIsABlM2SsQjE7-LpeW6DkQ9QeBwMuyo2IuT8IgjWbKyozqQPyXJE13GGG5KvMaAj7WEALw_wcB")
    }
}
