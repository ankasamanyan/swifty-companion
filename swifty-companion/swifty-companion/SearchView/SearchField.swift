//
//  SearchField.swift
//  swifty-companion
//
//  Created by Anait Kasamanian on 14.07.24.
//

import Foundation
import SwiftUI

struct SearchField: View {
    @Binding var searchText: String
    
    
    var body: some View {
        HStack {
            TextField("Search", text: $searchText)
                .padding(15)
                .padding(.horizontal, 15)
                .background(Color(.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 20))
        }
        .padding(.horizontal, 25)
    }
}
