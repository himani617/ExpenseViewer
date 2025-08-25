
//
//  ExpenseRow.swift
//  ExpenseViewer
//
//  Created by HIMANI VARU on 21/08/25.
//

import SwiftUI

struct ExpenseRow: View {
    // View Input
    let expense: Expense
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(expense.title)
                    .font(.headline)
                Text(expense.formattedDate)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Text(expense.formattedAmount)
                .font(.headline)
                .foregroundColor(.blue)
        }
        .padding(.vertical, 4)
        
        // Accessibility Support
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(expense.title), \(expense.formattedAmount), \(expense.formattedDate)")
    }
}
