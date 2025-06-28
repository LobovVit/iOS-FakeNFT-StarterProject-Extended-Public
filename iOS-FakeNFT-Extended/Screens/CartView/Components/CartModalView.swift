import SwiftUI
import Kingfisher

struct CartModalView: View {
    @Bindable var viewModel: CartViewModel
    
    // MARK: - Body
    
    var body: some View {
        VStack(spacing: 12) {
            nftImage
            modalTitle
            modalButtons
        }
        .frame(maxWidth: 262)
    }
    
    // MARK: - Content
    
    private var nftImage: some View {
        KFImage(URL(string: viewModel.selectedNft?.imageURL ?? ""))
            .placeholder {
                ProgressView()
            }
            .resizable()
            .scaledToFill()
            .frame(width: 108, height: 108)
            .clipped()
            .cornerRadius(12)
    }
    
    private var modalTitle: some View {
        Text("Вы уверены, что хотите\nудалить объект из корзины?")
            .font(Fonts.smallRegular)
            .foregroundColor(.blackDynamicYP)
            .multilineTextAlignment(.center)
            .padding(.bottom, 8)
    }
    
    private var modalButtons: some View {
        HStack(spacing: 8) {
            CartModalActionButton(
                title: String(localized: "Remove"),
                titleColor: .redUniversalYP
            ) {
                viewModel.isShowingRemoveModal = false
                // TODO: добавить логику удаления nft
            }
            
            CartModalActionButton(
                title: String(localized: "Return"),
                titleColor: .whiteDynamicYP
            ) {
                viewModel.isShowingRemoveModal = false
            }
        }
    }
}

#Preview {
    CartModalView(viewModel: CartViewModel())
}
