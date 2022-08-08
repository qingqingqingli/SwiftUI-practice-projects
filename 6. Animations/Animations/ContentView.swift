//
//  ContentView.swift
//

import SwiftUI

struct ContentView: View {
    @State private var animationAmount = 1.0
    
    var body: some View {
        Button("Tap Me") {
            animationAmount += 1
        }
        .padding(50)
        .background(.yellow)
        .foregroundColor(.white)
        .clipShape(Circle())
        .scaleEffect(animationAmount)
        // no blur by default
        .blur(radius: (animationAmount - 1) * 3)
        .animation(
            .easeInOut(duration: 1)
            // be careful with the repeat count
            // The program always needs to come back to match the state
            .repeatCount(2, autoreverses: true),
            value: animationAmount
        )
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
