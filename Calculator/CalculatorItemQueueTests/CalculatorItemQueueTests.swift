//
//  CalculatorTests.swift
//  CalculatorTests
//
//  Created by Kay on 2022/05/17.
//

import XCTest
@testable import Calculator

class CalculatorTests: XCTestCase {

    var sut: CalculatorItemQueue<String>!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = CalculatorItemQueue<String>()
    }

    override func tearDownWithError() throws {
        try super.setUpWithError()
        sut = nil
    }

    func test_isQueueEmpty() {
        let result = sut.isEmpty
        XCTAssertEqual(result, true)
    }
    
    func test_isQueueNil() {
        let result = sut.dequeue()
        XCTAssertEqual(result, nil)
    }
    
    func test_isCountMethodWorksProperly() {
        sut.enqueue("1")
        sut.enqueue("2")
        sut.enqueue("3")
        XCTAssertEqual(sut.count, 3)
    }
    
    func test_isFrontMethodWorksAsExpected() {
        sut.enqueue("1")
        sut.enqueue("2")
        sut.enqueue("3")
        let result = sut.front
        XCTAssertEqual(result, "1")
    }
    
    func test_isRearMethodWorksAsExpected() {
        sut.enqueue("1")
        sut.enqueue("2")
        sut.enqueue("3")
        let result = sut.rear
        XCTAssertEqual(result, "3")
    }
    
    func test_isClearMethodWorksAsExpected() {
        sut.enqueue("1")
        sut.enqueue("2")
        sut.enqueue("3")
        sut.clear()
        XCTAssertEqual(sut.count, 0)
    }
}