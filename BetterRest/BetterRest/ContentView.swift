//
//  ContentView.swift
//

import SwiftUI

struct ContentView: View {
    @State private var sleepAmount = 8.0
    @State private var wakeUp = Date.now
    
    var body: some View {
        VStack {
            Stepper("\(sleepAmount.formatted()) hours",
                    value: $sleepAmount,
                    in: 4...12,
                    step: 0.5
            )
            // So screen readers can use VoiceOver
            DatePicker("Please enter a date",
                       selection: $wakeUp,
                       in: Date.now...,
                       displayedComponents: .hourAndMinute)
                .labelsHidden()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
