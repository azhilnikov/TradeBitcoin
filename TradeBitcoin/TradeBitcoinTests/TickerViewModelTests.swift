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
  private var apiRequest: APIRequest!
  private var mockTickerViewController: MockTickerViewController!
  
  override func setUp() {
    super.setUp()
    
    mockTickerViewController = MockTickerViewController()
    apiRequest = APIRequest()
    
    sut = TickerViewModel(localeIdentifier: "en-GB", request: apiRequest)
    apiRequest.delegate = sut
    sut.delegate = mockTickerViewController
  }

  override func tearDown() {
    sut = nil
    apiRequest = nil
    mockTickerViewController = nil
    
    super.tearDown()
  }
  
  func testCurrencySymbolIsPound() {
    XCTAssertEqual(sut.currencySymbol, "£")
  }
  
  func testUpdateSellPrice() {
    let data = TestsHelper.loadData(from: "Ticker")!
    apiRequest.delegate?.didRequestComplete(.success(data))
    XCTAssertEqual(mockTickerViewController.sellPrice, "6,347.52")
  }
  
  func testUpdateSellPriceDirection() {
    let data = TestsHelper.loadData(from: "Ticker")!
    apiRequest.delegate?.didRequestComplete(.success(data))
    XCTAssertEqual(mockTickerViewController.sellPriceDirection, .down)
  }
  
  func testUpdateLowestSellPrice() {
    let data = TestsHelper.loadData(from: "Ticker")!
    apiRequest.delegate?.didRequestComplete(.success(data))
    XCTAssertEqual(mockTickerViewController.lowestSellPrice, "6,347.52")
  }
  
  func testUpdateBuyPrice() {
    let data = TestsHelper.loadData(from: "Ticker")!
    apiRequest.delegate?.didRequestComplete(.success(data))
    XCTAssertEqual(mockTickerViewController.buyPrice, "6,347.53")
  }
  
  func testUpdateBuyPriceDirection() {
    let data = TestsHelper.loadData(from: "Ticker")!
    apiRequest.delegate?.didRequestComplete(.success(data))
    XCTAssertEqual(mockTickerViewController.buyPriceDirection, .down)
  }
  
  func testUpdateHighestBuyPrice() {
    let data = TestsHelper.loadData(from: "Ticker")!
    apiRequest.delegate?.didRequestComplete(.success(data))
    XCTAssertEqual(mockTickerViewController.highestBuyPrice, "6,347.53")
  }
  
  func testUpdateSpread() {
    let data = TestsHelper.loadData(from: "Ticker")!
    apiRequest.delegate?.didRequestComplete(.success(data))
    XCTAssertEqual(mockTickerViewController.spread, "0.01")
  }
  
  func testNegativeUpdateSpread() {
    let data = TestsHelper.loadData(from: "NegativeSpread")!
    apiRequest.delegate?.didRequestComplete(.success(data))
    XCTAssertEqual(mockTickerViewController.spread, "-0.20")
  }
  
  func testSameDirectionSellPrice() {
    let data = TestsHelper.loadData(from: "EqualPrice")!
    apiRequest.delegate?.didRequestComplete(.success(data))
    XCTAssertEqual(mockTickerViewController.sellPriceDirection, .same)
  }
  
  func testSameDirectionBuyPrice() {
    let data = TestsHelper.loadData(from: "EqualPrice")!
    apiRequest.delegate?.didRequestComplete(.success(data))
    XCTAssertEqual(mockTickerViewController.buyPriceDirection, .same)
  }
  
  func testUpDirectionSellPrice() {
    let data = TestsHelper.loadData(from: "SellPriceHigherThanLast")!
    apiRequest.delegate?.didRequestComplete(.success(data))
    XCTAssertEqual(mockTickerViewController.sellPriceDirection, .up)
  }
  
  func testUpDirectionBuyPrice() {
    let data = TestsHelper.loadData(from: "BuyPriceHigherThanLast")!
    apiRequest.delegate?.didRequestComplete(.success(data))
    XCTAssertEqual(mockTickerViewController.buyPriceDirection, .up)
  }
  
  func testLowestSellPriceUpdate() {
    let data1 = TestsHelper.loadData(from: "Ticker")!
    apiRequest.delegate?.didRequestComplete(.success(data1))
    let data2 = TestsHelper.loadData(from: "LowestHighestPrice")!
    apiRequest.delegate?.didRequestComplete(.success(data2))
    XCTAssertEqual(mockTickerViewController.lowestSellPrice, "6,345.08")
  }
  
  func testHighestBuyPriceUpdate() {
    let data1 = TestsHelper.loadData(from: "Ticker")!
    apiRequest.delegate?.didRequestComplete(.success(data1))
    let data2 = TestsHelper.loadData(from: "LowestHighestPrice")!
    apiRequest.delegate?.didRequestComplete(.success(data2))
    XCTAssertEqual(mockTickerViewController.highestBuyPrice, "6,349.21")
  }
  
  func testLowestSellPriceDoesNotUpdate() {
    let data1 = TestsHelper.loadData(from: "LowestHighestPrice")!
    apiRequest.delegate?.didRequestComplete(.success(data1))
    let data2 = TestsHelper.loadData(from: "Ticker")!
    apiRequest.delegate?.didRequestComplete(.success(data2))
    XCTAssertEqual(mockTickerViewController.lowestSellPrice, "6,345.08")
  }
  
  func testHighestBuyPriceDoesNotUpdate() {
    let data1 = TestsHelper.loadData(from: "LowestHighestPrice")!
    apiRequest.delegate?.didRequestComplete(.success(data1))
    let data2 = TestsHelper.loadData(from: "Ticker")!
    apiRequest.delegate?.didRequestComplete(.success(data2))
    XCTAssertEqual(mockTickerViewController.highestBuyPrice, "6,349.21")
  }
}

private class MockTickerViewController: TickerViewModelDelegate {
  
  private(set) var sellPrice = ""
  private(set) var sellPriceDirection: PriceDirection = .same
  private(set) var buyPrice = ""
  private(set) var buyPriceDirection: PriceDirection = .same
  private(set) var spread = ""
  private(set) var lowestSellPrice: String?
  private(set) var highestBuyPrice: String?
  
  func didUpdateSellPrice(_ price: String, direction: PriceDirection) {
    sellPrice = price
    sellPriceDirection = direction
  }
  
  func didUpdateBuyPrice(_ price: String, direction: PriceDirection) {
    buyPrice = price
    buyPriceDirection = direction
  }
  
  func didUpdateSpread(_ spread: String) {
    self.spread = spread
  }
  
  func didUpdateLowestPrice(_ price: String) {
    lowestSellPrice = price
  }
  
  func didUpdateHighestPrice(_ price: String) {
    highestBuyPrice = price
  }
}
