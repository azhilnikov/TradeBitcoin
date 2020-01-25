//
//  TickerViewModelTests.swift
//  TradeBitcoinTests
//
//  Created by Alexey on 25/1/20.
//  Copyright © 2020 Alexey Zhilnikov. All rights reserved.
//

import XCTest
@testable import TradeBitcoin

class TickerViewModelTests: XCTestCase {

  private var sut: TickerViewModel!
  
  override func setUp() {
    super.setUp()
    sut = TickerViewModel(localeIdentifier: "en-GB")
  }

  override func tearDown() {
    sut = nil
    super.tearDown()
  }
  
  func testCurrencySymbolIsPound() {
    XCTAssertEqual(sut.currencySymbol, "£")
  }
}
