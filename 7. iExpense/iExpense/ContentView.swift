//
//  ContentView.swift
//

import SwiftUI

struct User: Codable {
    let firstName: String
    let lastName: String
}

struct ContentView: View {
    @State private var user = User(firstName: "Qing", lastName: "Li")
    
    var body: some View {
        Button("Save User") {
            let encoder = JSONEncoder()
            
            // Data can be written straight into UserDefaults
            if let data = try? encoder.encode(user) {
                UserDefaults.standard.set(data, forKey: "UserData")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
