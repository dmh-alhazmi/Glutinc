import SwiftUI

struct HomeView: View {
    @State private var searchText: String = ""

    var body: some View {
        ZStack(alignment: .top) {

            // الخلفية
            Image("bg2")                 // تأكدي الاسم نفس الموجود في Assets
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack {
                Spacer().frame(height: 100)
                SearchBar(text: $searchText) // السيرتش بار
                    .padding(.horizontal, 24)

                Spacer()
            }
        }
    }
}

#Preview {
    HomeView()
}
