//
//  ProfileView.swift
//  Glutinc
//
//  Created by Deemah Alhazmi on 01/12/2025.
//

import Foundation
import SwiftUI

struct ProfileView: View {
    @ObservedObject var vm: UserVM
    @State private var goToShop = false
    @State private var goToScan = false
    @State private var selectedTab: Int = 3   // 1 = shop, 2 = scan, 3 = profile

    var body: some View {
        ZStack {
            AppGradient.background.ignoresSafeArea()
            
            VStack(spacing: 20) {

                // Photo + name
                VStack(spacing: 6) {
                    ZStack {
                        if let img = vm.user.photo {
                            Image(uiImage: img).resizable().scaledToFill()
                        } else {
                            Image("userPhoto").resizable().scaledToFill()
                        }
                    }
                    .frame(width: 110, height: 110).clipShape(Circle())
                    .overlay(Circle().stroke(.white.opacity(0.85), lineWidth: 3))

                    Text(vm.user.name).foregroundStyle(AppColors.textPrimary)
                        .font(.system(size: 22, weight: .semibold))
                }
                .padding(.top, 40)

                // Two cards row
                HStack(spacing: 16) {
                    ForEach(vm.user.savedImages, id: \.self) { ProductCard(imageName: $0) }
                }
                .padding(.horizontal)

                Spacer(minLength: 0)

                // Tiny bottom bar (icons only – static)
                // Tiny bottom bar (icons only – ACTIVE)
                HStack(spacing: 60) {

                    // SHOP
                    Button {
                        selectedTab = 1
                        goToShop = true
                    } label: {
                        Image(systemName: "basket")
                            .foregroundStyle(selectedTab == 1 ? .blue : .white)
                    }

                    // SCAN
                    Button {
                        selectedTab = 2
                        goToScan = true
                    } label: {
                        Image(systemName: "barcode.viewfinder")
                            .foregroundStyle(selectedTab == 2 ? .blue : .white)
                    }

                    // PROFILE
                    Button {
                        selectedTab = 3
                    } label: {
                        Image(systemName: "person.fill")
                            .foregroundStyle(selectedTab == 3 ? .blue : .white)
                    }
                }
                .glassEffect(.clear)
                .font(.system(size: 22))
                .padding(.bottom, 30)

                .font(.system(size: 22)).foregroundStyle(.white).padding(.bottom, 30)
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: SettingsView(vm: vm)) {
                    Image(systemName: "gearshape").foregroundStyle(.white).glassEffect()
                }
            }
        }
        // Arabic mirrors automatically; force if you preview Arabic only:
        //.environment(\.layoutDirection, .rightToLeft)
        .background(
            Group {
                NavigationLink("", isActive: $goToShop) {
                    Text("Shop Page (Coming Soon)")
                        .navigationTitle("Shop")
                }.hidden()

                NavigationLink("", isActive: $goToScan) {
                    Text("Scan Page (Coming Soon)")
                        .navigationTitle("Scan")
                }.hidden()
            }
        )

    }

}

#Preview("Profile – EN") {
    let vm = UserVM()
    // Optional demo data:
    // vm.user.savedImages = ["prod1","prod2"]  // make sure these exist in Assets
    // vm.user.name = "Jasmin"

    return NavigationStack {                 // show the toolbar gear in preview
        ProfileView(vm: vm)
    }
}

/*#Preview("الملف الشخصي – AR • RTL") {
    let vm = UserVM()
    vm.user.name = "جاسمين"
    return NavigationStack {
        ProfileView(vm: vm)
            .environment(\.layoutDirection, .rightToLeft) // force RTL in preview
    }
    .preferredColorScheme(.light)
}
*/
