//
//  ContentView.swift
//

import SwiftUI

struct ContentView: View {
    
    // we are happy to fit in as many as columns as possible
    let layout = [
        GridItem(.adaptive(minimum: 80, maximum: 100))
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: layout) {
                ForEach(0..<99) {
                    Text("Item \($0)")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
