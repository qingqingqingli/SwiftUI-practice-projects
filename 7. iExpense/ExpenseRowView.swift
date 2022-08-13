//
//  ExpenseRowView.swift
//

import SwiftUI

struct ExpenseRowView: View {
    let item: ExpenseItem
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
                Text(item.type)
            }
            Spacer()
            Text(item.amount, format: .currency(code: "USD"))
        }
        .padding(.horizontal, 8)
    }
}

struct ExpenseRowView_Previews: PreviewProvider {
    static var previews: some View {
        let item = ExpenseItem(name: "test", type: "Personal", amount: 10.0)
        
        ExpenseRowView(item: item)
    }
}
