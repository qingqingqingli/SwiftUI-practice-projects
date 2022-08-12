//
//  ContentView.swift
//

import SwiftUI

struct ContentView: View {
    
    @State private var isShowingSheet = false
    
    var body: some View {
        Button("Show sheet") {
            isShowingSheet.toggle()
        }
        .sheet(isPresented: $isShowingSheet) {
            SecondView(name: "Hello world!")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
