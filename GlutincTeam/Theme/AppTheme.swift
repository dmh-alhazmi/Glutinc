//
//  AppTheme.swift
//  GlutincTeam
//
//  Created by Deemah Alhazmi on 02/12/2025.
//

import Foundation
import SwiftUI

struct AppTheme {
    // MARK: - Colors from Assets
    let backgroundTop       = Color("BackgroundTop")
    let backgroundBottom    = Color("BackgroundBottom")
    let surface             = Color("Surface")
    let textPrimary         = Color("TextPrimary")
    let textSecondary       = Color("TextSecondary")
    let accent              = Color("AccentColor")
    let danger              = Color("DangerColor")

    // MARK: - Layout Tokens
    let cornerRadiusSmall: CGFloat = 12
    let cornerRadiusMedium: CGFloat = 16
    let cornerRadiusLarge: CGFloat = 20

    let shadowOpacity: Double = 0.15
    let shadowRadius: CGFloat = 12

    // MARK: - Background Gradient
    var backgroundGradient: LinearGradient {
        LinearGradient(
            colors: [backgroundTop, backgroundBottom],
            startPoint: .top,
            endPoint: .bottom
        )
    }
}

private struct ThemeKey: EnvironmentKey {
    static let defaultValue = AppTheme()
}

extension EnvironmentValues {
    var theme: AppTheme {
        get { self[ThemeKey.self] }
        set { self[ThemeKey.self] = newValue }
    }
}

extension View {
    func theme(_ theme: AppTheme) -> some View {
        environment(\.theme, theme)
    }
}
