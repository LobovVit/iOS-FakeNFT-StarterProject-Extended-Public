import SwiftUI

struct PaymentView: View {
    var body: some View {
        VStack {
            EmptyView()
        }
        .navigationTitle(String(localized: "Select payment method"))
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    PaymentView()
}
