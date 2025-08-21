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

        let exp = Expense(dict: dict)
        XCTAssertNotNil(exp)
        XCTAssertEqual(exp?.id, "1")
        XCTAssertEqual(exp?.title, "Flight to SF")
        XCTAssertEqual(exp?.amount, 230.50)
    }

    func testExpenseFormattedValues() throws {
        let dict: [String: Any] = [
            "id": "2",
            "title": "Hotel",
            "amount": 550.00,
            "date": "2021-08-03T01:50:00+01:00"
        ]

        guard let exp = Expense(dict: dict) else {
            XCTFail("Expense parsing failed")
            return
        }

        XCTAssertTrue(exp.formattedAmount.count > 0)
        XCTAssertTrue(exp.formattedDate.count > 0)
    }

}
