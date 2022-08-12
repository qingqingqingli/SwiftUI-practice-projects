//
//  SecondView.swift
//

import SwiftUI

struct SecondView: View {
    
    let name: String
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Button("dismiss") {
            dismiss()
        }
    }
}
