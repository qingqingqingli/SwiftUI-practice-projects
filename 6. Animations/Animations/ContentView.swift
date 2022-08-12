//
//  ContentView.swift
//

import SwiftUI

struct ContentView: View {
    
    @State private var isShowingColor = false
    
    var body: some View {
        VStack {
            Button("Tap me") {
                withAnimation {
                    isShowingColor.toggle()
                }
            }
            
            if isShowingColor {
                Rectangle()
                    .fill(.yellow)
                    .frame(width: 200, height: 200)
                    .transition(.asymmetric(insertion: .scale, removal: .opacity))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
