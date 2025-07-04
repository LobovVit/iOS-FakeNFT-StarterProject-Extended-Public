import SwiftUI

struct PaymentView: View {
    private enum Constants {
        static let buttonHeight: CGFloat = 60
        static let buttonCornerRadius: CGFloat = 16
        static let webViewURL: String = "https://practicum.yandex.ru/"
    }
    
    @ObservedObject var viewModel: CartViewModel
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            currenciesList
            Spacer()
            purchaseBlock
        }
        .navigationTitle(String(localized: "Select payment method"))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)
    }
    
    private var currenciesList: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 7) {
                ForEach(viewModel.currencies) { currency in
                    CurrencyCell(
                        currency: currency,
                        isSelected: viewModel.selectedCurrency?.id == currency.id
                    )
                    .onTapGesture {viewModel.selectCurrency(currency)}
                }
            }
            .padding(.vertical, 20)
            .padding(.horizontal, 16)
        }
    }
    
    private var purchaseBlock: some View {
        VStack(alignment: .leading, spacing: 16) {
            textBlock
            button
        }
        .padding(16)
        .background(
            Color.lightGreyDynamicYP
                .cornerRadius(12, corners: [.topLeft, .topRight])
                .ignoresSafeArea(.container, edges: .bottom)
        )
    }
    
    private var textBlock: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(String(localized: "By making a purchase, you agree to the terms of the"))
                .font(Fonts.smallRegular)
                .foregroundColor(.blackDynamicYP)
            
            NavigationLink {
                WebView(url: URL(string: Constants.webViewURL))
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar(.hidden, for: .tabBar)
                    .ignoresSafeArea(.container, edges: .bottom)
            } label: {
                Text(String(localized: "User agreement"))
                    .font(Fonts.smallRegular)
                    .foregroundColor(.blueUniversalYP)
            }
        }
    }
    
    private var button: some View {
        Button(action: {
            // TODO: Действие при оплате
        }) {
            Text(String(localized: "Pay"))
                .font(Fonts.bodyBold)
                .foregroundColor(.whiteDynamicYP)
                .frame(maxWidth: .infinity)
                .frame(height: Constants.buttonHeight)
                .background(.blackDynamicYP)
                .cornerRadius(Constants.buttonCornerRadius)
        }
    }
}

#Preview {
    PaymentView(viewModel: CartViewModel())
}
