//
//  ContentView.swift
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                ForEach(0..<99) { row in
                    NavigationLink {
                        Text("Detail \(row)")
                    } label: {
                        Text("Row \(row)")
                    }
                }
                .navigationTitle("SwiftUI")
            }
            .navigationViewStyle(.stack)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
