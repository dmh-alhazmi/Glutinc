//
//  ContentView.swift
//  Glutinc
//
//  Created by Deemah Alhazmi on 01/12/2025.
//

import SwiftUI


struct ContentView: View {
    @StateObject private var vm = UserVM()   // single source of truth

    var body: some View {
        NavigationStack {
            ProfileView(vm: vm)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: SettingsView(vm: vm)) {
                            Image(systemName: "gearshape")
                                .foregroundColor(.white)
                                .font(.system(size: 20))
                        }
                    }
                }
        }
    }
}

#Preview {
    ContentView()
}
