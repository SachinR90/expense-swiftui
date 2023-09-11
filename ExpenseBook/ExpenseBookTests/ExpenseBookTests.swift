//
//  ExpenseBookTests.swift
//  ExpenseBookTests
//
//  Created by Sachin Rao on 05/10/22.
//

@testable import ExpenseBook
import SwiftUI
import XCTest
final class ExpenseBookTests: XCTestCase {
    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}

    func testInvalidColorString() throws {
        let colorString = "#11029s9cH"
        XCTAssertNil(colorString.toColor())
    }

    func testValidColor3CharString() throws {
        let colorString = "#FFF"
        let color = colorString.toColor()
        XCTAssertNotNil(color)
    }

    func testValidColor6CharString() throws {
        let colorString = "#FF0000"
        let color = colorString.toColor()
        XCTAssertNotNil(color)
    }

    func testValidColor7CharString() throws {
        let colorString = "#FFFFFFE"
        let color = colorString.toColor()
        XCTAssertNil(color)
    }

    func testValidColor8CharString() throws {
        let colorString = "#00FFFFFF"
        let color = colorString.toColor()
        XCTAssertNotNil(color)
    }

    func testEmptyColorString() throws {
        let colorString = ""
        XCTAssertNil(colorString.toColor())
    }

    func testNilColorString() throws {
        let colorString: String? = nil
        XCTAssertNil(colorString?.toColor())
    }
}
