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
  
  func testUpdateFirstSellPriceDirection() {
    let data = TestsHelper.loadData(from: "Ticker")!
    apiRequest.delegate?.didRequestComplete(.success(data))
    XCTAssertEqual(mockTickerViewController.sellPriceDirection, .same)
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
  
  func testUpdateFirstBuyPriceDirection() {
    let data = TestsHelper.loadData(from: "Ticker")!
    apiRequest.delegate?.didRequestComplete(.success(data))
    XCTAssertEqual(mockTickerViewController.buyPriceDirection, .same)
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
    let data1 = TestsHelper.loadData(from: "Ticker")!
    apiRequest.delegate?.didRequestComplete(.success(data1))
    let data2 = TestsHelper.loadData(from: "SellPriceHigherThanLast")!
    apiRequest.delegate?.didRequestComplete(.success(data2))
    XCTAssertEqual(mockTickerViewController.sellPriceDirection, .up)
  }
  
  func testUpDirectionBuyPrice() {
    let data1 = TestsHelper.loadData(from: "Ticker")!
    apiRequest.delegate?.didRequestComplete(.success(data1))
    let data2 = TestsHelper.loadData(from: "BuyPriceHigherThanLast")!
    apiRequest.delegate?.didRequestComplete(.success(data2))
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
  
  func testNilUnitsOrderUpdate() {
    sut.didUpdateOrder(nil, orderType: .units)
    XCTAssertNil(mockTickerViewController.units)
  }
  
  func testNilAmountOrderUpdate() {
    sut.didUpdateOrder(nil, orderType: .amount)
    XCTAssertNil(mockTickerViewController.amount)
  }
  
  func testConfirmIsNotEnabledAfterNilUnitsOrderUpdate() {
    sut.didUpdateOrder(nil, orderType: .units)
    XCTAssertFalse(mockTickerViewController.isConfirmEnabled)
  }
  
  func testConfirmIsNotEnabledAfterNilAmountOrderUpdate() {
    sut.didUpdateOrder(nil, orderType: .amount)
    XCTAssertFalse(mockTickerViewController.isConfirmEnabled)
  }
  
  func testUnitsOrderUpdate() {
    let data = TestsHelper.loadData(from: "Ticker")!
    apiRequest.delegate?.didRequestComplete(.success(data))
    sut.didUpdateOrder(Decimal(15.09), orderType: .units)
    guard let amount = mockTickerViewController.amount else {
      XCTFail()
      return
    }
    XCTAssertEqual((amount as NSDecimalNumber).doubleValue, 95784.23, accuracy: 0.01)
  }
  
  func testConfirmIsEnabledAfterUnitsOrderUpdate() {
    let data = TestsHelper.loadData(from: "Ticker")!
    apiRequest.delegate?.didRequestComplete(.success(data))
    sut.didUpdateOrder(Decimal(15.09), orderType: .units)
    XCTAssertTrue(mockTickerViewController.isConfirmEnabled)
  }
  
  func testAmountOrderUpdate() {
    let data = TestsHelper.loadData(from: "Ticker")!
    apiRequest.delegate?.didRequestComplete(.success(data))
    sut.didUpdateOrder(Decimal(11.94), orderType: .amount)
    guard let units = mockTickerViewController.units else {
      XCTFail()
      return
    }
    XCTAssertEqual((units as NSDecimalNumber).doubleValue, 531.62, accuracy: 0.01)
  }
  
  func testConfirmIsEnabledAfterAmountOrderUpdate() {
    let data = TestsHelper.loadData(from: "Ticker")!
    apiRequest.delegate?.didRequestComplete(.success(data))
    sut.didUpdateOrder(Decimal(11.94), orderType: .amount)
    XCTAssertTrue(mockTickerViewController.isConfirmEnabled)
  }
}

private class MockTickerViewController: TickerViewModelDelegate {
  
  private(set) var sellPrice: String?
  private(set) var sellPriceDirection: PriceDirection = .same
  private(set) var buyPrice: String?
  private(set) var buyPriceDirection: PriceDirection = .same
  private(set) var spread: String?
  private(set) var lowestSellPrice: String?
  private(set) var highestBuyPrice: String?
  private(set) var units: Decimal?
  private(set) var amount: Decimal?
  private(set) var isConfirmEnabled = false
  
  func didUpdateSellPrice(_ price: String?, direction: PriceDirection) {
    sellPrice = price
    sellPriceDirection = direction
  }
  
  func didUpdateBuyPrice(_ price: String?, direction: PriceDirection) {
    buyPrice = price
    buyPriceDirection = direction
  }
  
  func didUpdateSpread(_ spread: String?) {
    self.spread = spread
  }
  
  func didUpdateLowestPrice(_ price: String?) {
    lowestSellPrice = price
  }
  
  func didUpdateHighestPrice(_ price: String?) {
    highestBuyPrice = price
  }
  
  func needToUpdateOrderUnits(_ units: Decimal?) {
    self.units = units
  }
  
  func needToUpdateOrderAmount(_ amount: Decimal?) {
    self.amount = amount
  }
  
  func updateOrderConfirm(isEnabled: Bool) {
    isConfirmEnabled = isEnabled
  }
}
