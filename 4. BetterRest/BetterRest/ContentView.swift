//
//  ContentView.swift
//

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    // alert to show actual sleep time
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("When do you want to wake up?").font(.headline)) {
                    DatePicker("Please enter a time",
                               selection: $wakeUp,
                               displayedComponents: .hourAndMinute)
                    .labelsHidden()
                    .onChange(of: wakeUp) { _ in
                        calculatedBedTime()
                    }
                }
                
                Section(header: Text("Desired amount of sleep").font(.headline)) {
                    Stepper("\(sleepAmount.formatted()) hours",
                            value: $sleepAmount,
                            in: 4...12,
                            step: 0.25
                    )
                    .onChange(of: sleepAmount) { _ in
                        calculatedBedTime()
                    }
                }
                
                Section(header: Text("Daily coffee intake").font(.headline)) {
                    Picker(coffeeAmount == 1 ? "1 cup" : "\(coffeeAmount) cups",
                           selection: $coffeeAmount) {
                        ForEach(1...20, id: \.self) {
                            Text("\($0)")
                        }
                    }
                           .onChange(of: coffeeAmount) { newValue in
                               calculatedBedTime()
                           }
                }
                
                Section(header: Text("Your ideal sleep time is...").font(.headline)) {
                    Text("\(alertMessage)")
                }
            }
            .navigationTitle("Better Rest")
            .onAppear {
                calculatedBedTime()
            }
        }
    }
    
    func calculatedBedTime() {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let predication = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - predication.actualSleep
            alertTitle = "Your ideal bed time is ..."
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
            
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
