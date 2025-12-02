//
//  SettingsView.swift
//  Glutinc
//
//  Created by Deemah Alhazmi on 01/12/2025.
//

import Foundation
import SwiftUI
import PhotosUI

struct SettingsView: View {
    @ObservedObject var vm: UserVM
    @State private var showNameSheet = false
    @State private var nameDraft = ""
    @State private var pickerItem: PhotosPickerItem?
    @State private var showDeleteConfirm = false
    @State private var showSignOutConfirm = false

    var body: some View {
        ZStack {
            AppGradient.background.ignoresSafeArea()
            ScrollView {
                VStack(spacing: 22) {

                    // MARK: General
                    SectionHeader(title: NSLocalizedString("General", comment: ""))
                    // Notifications toggle inline
                    HStack {
                        Label(NSLocalizedString("Notifications", comment: ""), systemImage: "bell")
                            .foregroundStyle(.white)
                        Spacer()
                        Toggle("", isOn: $vm.user.notificationsEnabled).labelsHidden()
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 16).fill(AppColors.card))

                    SettingRow(icon: "pencil", title: "Edit Name") {
                        nameDraft = vm.user.name; showNameSheet = true
                    }
                    // Edit photo via PhotosPicker
                    PhotosPicker(selection: $pickerItem, matching: .images) {
                        HStack(spacing: 14) {
                            Image(systemName: "camera.circle").foregroundStyle(.white).font(.system(size: 18, weight: .medium))
                            Text(NSLocalizedString("Edit Profile Photo", comment: "")).foregroundStyle(.white)
                            Spacer()
                            Image(systemName: "chevron.forward").foregroundStyle(.white.opacity(0.5))
                        }
                        .padding().background(RoundedRectangle(cornerRadius: 16).fill(AppColors.card))
                    }
                    .onChange(of: pickerItem) { _, newItem in
                        guard let newItem else { return }
                        Task {
                            if let data = try? await newItem.loadTransferable(type: Data.self),
                               let img = UIImage(data: data) {
                                vm.updatePhoto(img)
                            }
                        }
                    }

                    // MARK: About
                    SectionHeader(title: NSLocalizedString("About the App", comment: ""))
                    SettingRow(icon: "info.circle",       title: NSLocalizedString("About", comment: "")) {}
                    SettingRow(icon: "lock.shield",       title: NSLocalizedString("Privacy Policy", comment: "")) {}
                    SettingRow(icon: "envelope",          title: NSLocalizedString("Contact Support", comment: "")) {}

                    // MARK: Danger Zone
                    SectionHeader(title: NSLocalizedString("Danger Zone", comment: ""))
                    SettingRow(icon: "trash", title: NSLocalizedString("Delete Account", comment: ""), tint: .red) {
                        showDeleteConfirm = true
                    }
                    SettingRow(icon: "arrowshape.turn.up.left", title: NSLocalizedString("Sign Out", comment: ""), tint: .red) {
                        showSignOutConfirm = true
                    }
                }
                .padding(.horizontal).padding(.bottom, 40)
            }
        }
        .navigationTitle(NSLocalizedString("Settings", comment: ""))
        .confirmationDialog(NSLocalizedString("Are you sure?", comment: ""),
                            isPresented: $showDeleteConfirm, titleVisibility: .visible) {
            Button(NSLocalizedString("Delete Account", comment: ""), role: .destructive) { /* call delete */ }
            Button(NSLocalizedString("Cancel", comment: ""), role: .cancel) {}
        }
        .alert(NSLocalizedString("Sign out?", comment: ""), isPresented: $showSignOutConfirm) {
            Button(NSLocalizedString("Cancel", comment: ""), role: .cancel) {}
            Button(NSLocalizedString("Sign Out", comment: ""), role: .destructive) { /* call signout */ }
        }
        // Edit name sheet
        .sheet(isPresented: $showNameSheet) {
            NavigationStack {
                Form {
                    TextField(NSLocalizedString("Your name", comment: ""), text: $nameDraft)
                }
                .navigationTitle(NSLocalizedString("Edit Name", comment: ""))
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button(NSLocalizedString("Cancel", comment: "")) { showNameSheet = false }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button(NSLocalizedString("Save", comment: "")) {
                            vm.updateName(nameDraft); showNameSheet = false
                        }
                    }
                }
            }
        }
    }
}
