//
//  SearchBar.swift
//  GlutincTeam
//
//  Created by dana on 11/06/1447 AH.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        HStack(spacing: 12) {

            
            Image("Search")
                .resizable()
                .renderingMode(.original)
                .scaledToFit()
                .frame(width: 22, height: 22)

           
            TextField(
                "",
                text: $text,
                prompt: Text("Search")
                    .foregroundColor(Color("GreyColor"))
            )
            .foregroundColor(Color("GreyColor"))
            .font(.system(size: 18, weight: .regular))
            .disableAutocorrection(true)
            .tint(Color("GreyColor"))

            Spacer(minLength: 0)

        
            Image("mic")
                .resizable()
                .renderingMode(.original)
                .scaledToFit()
                .frame(width: 22, height: 22)
        }
        .padding(.horizontal, 18)
        .frame(height: 56)
        .background(Color("TextPrimary"))
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
        .shadow(
            color: Color.black.opacity(0.08),
            radius: 18,
            x: 0,
            y: 8
        )
    }
}
