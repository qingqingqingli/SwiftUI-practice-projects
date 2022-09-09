//
//  ContentView.swift
//

import SwiftUI


struct ContentView: View {
    @State private var userName: String = ""
    @State private var email: String = ""
    
    var body: some View {
        Form {
            Section {
                TextField("User Name", text: $userName)
                TextField("Email", text: $email)
            }
            
            Section {
                Button("Create account") {
                    print("Creating account")
                }
            }
            .disabled(shouldDisableButton)
        }
    }
    
    var shouldDisableButton : Bool {
        userName.count < 5 || email.count < 5
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
