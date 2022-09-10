//
//  CheckoutView.swift
//

import SwiftUI

struct CheckoutView: View {

    @ObservedObject var orderObservable: OrderObservable
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    
    let imageURL: String = "https://hws.dev/img/cupcakes@3x.jpg"
    // A good option for prototyping
    let serverURL: String = "https://reqres.in/api/cupcakes"
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: imageURL)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                
                Text("Your total is \(orderObservable.order.cost, format: .currency(code: "USD"))")
                    .font(.title)
                
                Button("Place order") {
                    Task {
                        await placeOrder()
                    }
                }.padding()
            }
        }
        .alert("Thank you!", isPresented: $showingConfirmation) {
            Button("OK") {}
        } message: {
            Text(confirmationMessage)
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func placeOrder() async {
        // 1. convert order object to JSON data to be sent
        
        guard let encoded = try? JSONEncoder().encode(orderObservable.order) else {
            print ("Failed to encode order")
            return
        }
        
        // 2. tell Swift how to send the data over networking call
        let url = URL(string: serverURL)!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        // 3. run request and process response
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            
            // handle result
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order for \(decodedOrder.quantity) x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
            showingConfirmation = true
        } catch {
            print("Checkout failed.")
            confirmationMessage = "Your order failed."
            showingConfirmation = true
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(orderObservable: OrderObservable())
    }
}
