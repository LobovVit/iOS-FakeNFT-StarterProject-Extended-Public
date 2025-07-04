import SwiftUI

struct PaymentView: View {
    @ObservedObject var viewModel: CartViewModel
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            currenciesList
        }
        .navigationTitle(String(localized: "Select payment method"))
        .navigationBarTitleDisplayMode(.inline)
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
}

#Preview {
    PaymentView(viewModel: CartViewModel())
}
