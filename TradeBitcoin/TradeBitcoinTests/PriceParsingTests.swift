//
//  PriceParsingTests.swift
//  TradeBitcoinTests
//
//  Created by Alexey on 26/1/20.
//  Copyright © 2020 Alexey Zhilnikov. All rights reserved.
//

import XCTest
@testable import TradeBitcoin

class PriceParsingTests: XCTestCase {

  private let data = TestsHelper.loadData(from: "Ticker")!
  private let decoder = JSONDecoder()
  private var sut: TickerPrice!
  
  override func setUp() {
    super.setUp()
    sut = try! decoder.decode(TickerPrice.self, from: data)
  }

  override func tearDown() {
    sut = nil
    super.tearDown()
  }
  
  func testTickersNumber() {
    XCTAssertEqual(sut.count, 22)
  }
  
  func testLastPriceGBP() {
    XCTAssertEqual(sut["GBP"]?.last, 6347.54)
  }
  
  func testBuyPriceGBP() {
    XCTAssertEqual(sut["GBP"]?.buy, 6347.53)
  }
  
  func testSellPriceGBP() {
    XCTAssertEqual(sut["GBP"]?.sell, 6347.52)
  }
  
  func testSymbolPriceGBP() {
    XCTAssertEqual(sut["GBP"]?.symbol, "£")
  }
}
