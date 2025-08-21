//
//  ExpenseViewerUITests.swift
//  ExpenseViewerUITests
//
//  Created by HIMANI VARU on 21/08/25.
//

import XCTest

final class ExpenseViewerUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }


    func testExpensesListShowsData() throws {
        // Wait for splash to disappear
        sleep(3)

        let firstCell = app.cells.firstMatch
        XCTAssertTrue(firstCell.waitForExistence(timeout: 5), "Expense cell should exist")

        // Verify essential labels
        XCTAssertTrue(firstCell.staticTexts.element(boundBy: 0).exists, "Title should exist")
        XCTAssertTrue(firstCell.staticTexts.element(boundBy: 1).exists, "Amount should exist")
        XCTAssertTrue(firstCell.staticTexts.element(boundBy: 2).exists, "Date should exist")
    }
}
