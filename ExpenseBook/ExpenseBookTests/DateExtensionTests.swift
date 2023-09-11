//
//  DateExtensionTests.swift
//  ExpenseBookTests
//
//  Created by Sachin Rao on 20/10/22.
//

@testable import ExpenseBook
import XCTest
final class DateExtensionTests: XCTestCase {
    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}

    func testStartOfYear() throws {
        let date = Date()
        let startOfYear = date.startOfYear
        print("Date: \(startOfYear)")
        XCTAssertNotNil(startOfYear)
    }

    func testEndOfYear() throws {
        let date = Date()
        let endOfYear = date.endOfYear
        print("Date: \(endOfYear)")
        XCTAssertNotNil(endOfYear)
    }

    func testNextNDates() throws {
        let date = Date()
        let endOfYear = date.nextNYearDate(2)
        print("Date: \(endOfYear)")
        XCTAssertNotNil(endOfYear)
    }
}
