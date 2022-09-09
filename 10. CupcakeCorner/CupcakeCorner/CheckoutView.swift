//
//  CheckoutView.swift
//

import SwiftUI

struct CheckoutView: View {

    @ObservedObject var order: Order
    
    let imageURL: String = "https://hws.dev/img/cupcakes@3x.jpg"
    
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
                
                Text("Your total is \(order.cost, format: .currency(code: "USD"))")
                    .font(.title)
                
                Button("Place order", action: {})
                    .padding()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
