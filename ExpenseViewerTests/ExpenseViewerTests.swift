//
//  ExpenseViewerTests.swift
//  ExpenseViewerTests
//
//  Created by HIMANI VARU on 21/08/25.
//

import XCTest
@testable import ExpenseViewer

final class ExpenseViewerTests: XCTestCase {

    func testExpenseParsing() throws {
        let dict: [String: Any] = [
            "id": "1",
            "title": "Flight to SF",
            "amount": 230.50,
            "date": "2021-07-03T01:50:00+01:00"
        ]

        let exp = try XCTUnwrap(Expense(dict: dict), "Expense parsing failed")
        XCTAssertEqual(exp.id, "1")
        XCTAssertEqual(exp.title, "Flight to SF")
        XCTAssertEqual(exp.amount, 230.50)
    }

    func testExpenseFormattedValues() throws {
        let dict: [String: Any] = [
            "id": "2",
            "title": "Hotel",
            "amount": 550.00,
            "date": "2021-08-03T01:50:00+01:00"
        ]

        let exp = try XCTUnwrap(Expense(dict: dict), "Expense parsing failed")
        XCTAssertFalse(exp.formattedAmount.isEmpty, "Formatted amount should not be empty")
        XCTAssertFalse(exp.formattedDate.isEmpty, "Formatted date should not be empty")
    }

    func testExpenseFormattedDatePattern() throws {
        let dict: [String: Any] = [
            "id": "3",
            "title": "Taxi",
            "amount": 35.75,
            "date": "2025-08-25T20:00:00+05:30" // Use current date for example
        ]

        let exp = try XCTUnwrap(Expense(dict: dict), "Expense parsing failed")

        // Used DateFormatter to check expected output
        let df = DateFormatter()
        df.dateStyle = .medium
        df.timeStyle = .short

        let expectedDate = df.string(from: exp.date)
        XCTAssertEqual(exp.formattedDate, expectedDate, "Formatted date should match DateFormatter output")
    }
}
