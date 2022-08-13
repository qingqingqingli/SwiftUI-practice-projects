//
//  ExpenseRowView.swift
//

import SwiftUI

struct ExpenseRowView: View {
    let item: ExpenseItem
    
    private func amountColor(_ amount: Double) -> Color {
        switch amount {
        case 0..<10.0:
            return .red
        case 10.0...100.0:
            return .yellow
        case 100.0...:
            return .blue
        default:
            return .black
        }
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
                Text(item.type)
            }
            Spacer()
            Text(item.amount,
                 format: .currency(code: Expenses.currencyCode)
            )
            .foregroundColor(amountColor(item.amount))
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
