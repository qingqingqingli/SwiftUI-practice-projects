//
//  ContentView.swift
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ScrollView(.vertical) {
            // make it lazy stack so the view is only created when needed
            LazyVStack(spacing: 10) {
                ForEach(0..<100) {
                    CustomText("Item: \($0)")
                        .font(.title)
                }
            }
            // when it's a regular HStack or VStack
            // the size of ScrollView is based on the children content
            // so the maxWidth needs to be set on VStack not ScrollView
            // however when it's a lazy stack
            // it automatically takes up as much as space as possible
//            .frame(maxWidth: .infinity)
        }
    }
}

struct CustomText: View {
    let text: String
    
    var body: some View {
        Text(text)
    }
    
    init(_ text: String) {
        print("Creating a new CustomerText \(text)")
        self.text = text
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
