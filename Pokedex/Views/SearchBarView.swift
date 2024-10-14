//
//  SearchBarView.swift
//  Pokedex
//
//  Created by Ben Blakesley on 13/10/2024.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchText: String
    
    var body: some View {
        ZStack(alignment: .leading)
        {
            Color(.systemGray6)
                .cornerRadius(8)
            
            HStack
            {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                    .padding(.leading, 8)
                
                TextField("Search Pokemon...", text: $searchText)
                    .padding(8)
                    .autocorrectionDisabled(true)
                
                if !searchText.isEmpty {
                    Button(action: {
                        searchText = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                            .padding(.trailing, 8)
                    }
                    .padding(.trailing, 8)
                    .transition(.opacity)
                }
            }
        }
        .frame(height: 40)
        .padding(.horizontal)
        
    }
}
