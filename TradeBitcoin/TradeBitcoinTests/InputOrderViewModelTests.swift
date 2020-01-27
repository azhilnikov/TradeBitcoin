//
//  InputOrderViewModelTests.swift
//  TradeBitcoinTests
//
//  Created by Alexey on 28/1/20.
//  Copyright © 2020 Alexey Zhilnikov. All rights reserved.
//

import XCTest
@testable import TradeBitcoin

class InputOrderViewModelTests: XCTestCase {

  private var sut: InputOrderViewModel!
  
  override func setUp() {
    super.setUp()
    
    sut = InputOrderViewModel(orderType: .amount)
  }

  override func tearDown() {
    sut = nil
    
    super.tearDown()
  }
  
  func testShouldChangeNilCurrentValue() {
    XCTAssertTrue(sut.shouldChange(nil, by: "1"))
  }
  
  func testShouldChangeEmptyCurrentValue() {
    XCTAssertTrue(sut.shouldChange("", by: "1"))
  }
  
  func testShouldChangeCurrentValue() {
    XCTAssertTrue(sut.shouldChange("10", by: "2"))
  }
  
  func testShouldChangeCurrentValueByFirstDot() {
    XCTAssertTrue(sut.shouldChange("10", by: "."))
  }
  
  func testShouldChangeCurrentValueByFirstFractionDigit() {
    XCTAssertTrue(sut.shouldChange("10.", by: "4"))
  }
  
  func testShouldChangeCurrentValueBySecondFractionDigit() {
    XCTAssertTrue(sut.shouldChange("10.4", by: "5"))
  }
  
  func testShouldNotChangeCurrentValueByThirdFractionDigit() {
    XCTAssertFalse(sut.shouldChange("10.45", by: "5"))
  }
  
  func testShouldNotChangeCurrentValueByLetter() {
    XCTAssertFalse(sut.shouldChange("10", by: "c"))
  }

  func testValueOfNil() {
    XCTAssertNil(sut.valueOf(nil))
  }
  
  func testValueOfLetters() {
    XCTAssertNil(sut.valueOf("abc"))
  }
  
  func testValueOfDecimal() {
    XCTAssertEqual(sut.valueOf("12.34"), Decimal(12.34))
  }
  
  func testStringFromNil() {
    XCTAssertNil(sut.string(from: nil))
  }
  
  func testStringFromRightDecimal() {
    XCTAssertEqual(sut.string(from: Decimal(3444.09)), "3,444.09")
  }
}
