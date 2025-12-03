//
//  GlassTabBar.swift
//  GlutincTeam
//
//  Created by dana on 12/06/1447 AH.
//
import SwiftUI

enum Tab: CaseIterable {
    case home
    case camera
    case profile
    
    var iconName: String {
        switch self {
        case .home: return "wheat"
        case .camera: return "camera"
        case .profile: return "profile"
        }
    }
}

struct GlassTabBar: View {
    @Binding var selectedTab: Tab

    var body: some View {
        HStack(spacing: 0) {
            ForEach(Tab.allCases, id: \.self) { tab in
                Button {
                    selectedTab = tab
                } label: {
                    ZStack {
                        if selectedTab == tab {
                            RoundedRectangle(cornerRadius: 26)
                                .fill(Color("TextPrimary").opacity(0.95))
                                .shadow(color: .black.opacity(0.08), radius: 12, x: 0, y: 4)
                                .padding(.vertical, 4)
                                .padding(.horizontal, 4)
                        }

                        Image(tab.iconName)
                            .resizable()
                            .renderingMode(.original)
                            .scaledToFit()
                            .frame(width: 26, height: 26)
                    }
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(6)
        .background(
            RoundedRectangle(cornerRadius: 30)
                .fill(.ultraThinMaterial)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 30)
                .stroke(Color.white.opacity(0.7), lineWidth: 1)
        )
        .frame(width: 260, height: 72)
    }
}
