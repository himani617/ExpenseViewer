
//
//  Expense.swift
//  ExpenseViewer
//
//  Created by HIMANI VARU on 21/08/25.
//

import Foundation

extension Expense {
    var formattedAmount: String {
        let f = NumberFormatter()
        f.numberStyle = .currency
        return f.string(from: amount as NSDecimalNumber) ?? "\(amount)"
    }

    var formattedDate: String {
        let df = DateFormatter()
        df.dateStyle = .medium
        df.timeStyle = .short
        return df.string(from: date)
    }
}
