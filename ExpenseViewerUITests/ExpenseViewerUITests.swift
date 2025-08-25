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
        let firstCell = app.cells.firstMatch

        // Wait for the first cell to appear (up to 5 seconds)
        let existsPredicate = NSPredicate(format: "exists == true")
        let expectation = expectation(for: existsPredicate, evaluatedWith: firstCell, handler: nil)
        wait(for: [expectation], timeout: 5)

        // Verify the first cell exists
        XCTAssertTrue(firstCell.exists, "Expense cell should exist")

        // Verify essential labels within the first cell
        XCTAssertTrue(firstCell.staticTexts.element(boundBy: 0).exists, "Title should exist")
        XCTAssertTrue(firstCell.staticTexts.element(boundBy: 1).exists, "Amount should exist")
        XCTAssertTrue(firstCell.staticTexts.element(boundBy: 2).exists, "Date should exist")
    }
}
