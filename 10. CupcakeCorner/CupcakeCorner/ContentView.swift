//
//  ContentView.swift
//

import SwiftUI

struct ContentView: View {
    
    // the only place the order will be created
    @StateObject var orderObservable = OrderObservable()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $orderObservable.order.type) {
                        // only use indices with unmutable array
                        ForEach(Order.types.indices, id: \.self) {
                            Text(Order.types[$0])
                        }
                    }
                    
                    Stepper("Amount of cakes: \(orderObservable.order.quantity)", value: $orderObservable.order.quantity, in: 3...20)
                }
                
                Section {
                    Toggle("Any special requests?", isOn: $orderObservable.order.specialRequestEnabled.animation())
                    
                    if orderObservable.order.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn: $orderObservable.order.extraFrosting)
                        Toggle("Add extra sprinkles", isOn: $orderObservable.order.extraSprinkles)
                    }
                }
                
                Section {
                    NavigationLink {
                        AddressView(orderObservable: orderObservable)
                    } label: {
                        Text("Delivery details")
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
