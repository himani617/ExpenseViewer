
//
//  Expense.swift
//  ExpenseViewer
//
//  Created by HIMANI VARU on 21/08/25.
//

import Foundation

struct Expense: Identifiable {
    let id: String
    let title: String
    let amount: Decimal
    let date: Date

    private static let iso8601: ISO8601DateFormatter = {
        let f = ISO8601DateFormatter()
        f.formatOptions = [.withInternetDateTime, .withColonSeparatorInTimeZone]
        return f
    }()

    init?(dict: [String: Any]) {
        guard
            let id = dict["id"] as? String,
            let title = dict["title"] as? String,
            let num = dict["amount"] as? NSNumber,
            let dateStr = dict["date"] as? String,
            let date = Expense.iso8601.date(from: dateStr)
        else { return nil }

        self.id = id
        self.title = title
        self.amount = num.decimalValue
        self.date = date
    }
}


