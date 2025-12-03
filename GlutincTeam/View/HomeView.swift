import SwiftUI

struct HomeView: View {
    @State private var searchText: String = ""
    @State private var selectedTab: Tab = .home

    var body: some View {
        ZStack {

            Image("bg2")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack {
                Spacer().frame(height: 100)

                SearchBar(text: $searchText)
                    .padding(.horizontal, 24)

                Spacer()

                GlassTabBar(selectedTab: $selectedTab)
                    .padding(.bottom, 40)
            }
        }
    }
}

#Preview {
    HomeView()
}
