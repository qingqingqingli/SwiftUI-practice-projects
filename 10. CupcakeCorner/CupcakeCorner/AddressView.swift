//
//  AddressView.swift
//

import SwiftUI

struct AddressView: View {
    // only accessing it and not creating it
    @ObservedObject var orderObservable: OrderObservable
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $orderObservable.order.name)
                TextField("Street Address", text: $orderObservable.order.streetAddress)
                TextField("City", text: $orderObservable.order.city)
                TextField("Zip", text: $orderObservable.order.zip)
            }
            
            Section {
                NavigationLink {
                    CheckoutView(orderObservable: orderObservable)
                } label: {
                    Text("Check out")
                }
                
            }
            .disabled(orderObservable.order.hasValidAddress == false)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(orderObservable: OrderObservable())
    }
}
