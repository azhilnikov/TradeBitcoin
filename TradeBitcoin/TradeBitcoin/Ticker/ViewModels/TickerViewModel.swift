//
//  TickerViewModel.swift
//  TradeBitcoin
//
//  Created by Alexey on 25/1/20.
//  Copyright © 2020 Alexey Zhilnikov. All rights reserved.
//

import Foundation

typealias TickerPrice = [String: Price]

protocol TickerViewModelDelegate: class {
  func didUpdateSellPrice(_ price: String, direction: PriceDirection)
  func didUpdateBuyPrice(_ price: String, direction: PriceDirection)
  func didUpdateSpread(_ spread: String)
  func didUpdateLowestPrice(_ price: String)
  func didUpdateHighestPrice(_ price: String)
  func needToUpdateOrderUnits(_ units: Decimal)
  func needToUpdateOrderAmount(_ amount: Decimal)
  func updateOrderConfirm(isEnabled: Bool)
}

final class TickerViewModel {
  
  weak var delegate: TickerViewModelDelegate?
  private(set) var currencySymbol: String?
  
  private let localeIdentifier: String
  private let request: APIRequest
  private let pollingInterval: TimeInterval = 15
  
  private var price: Price? {
    return tickers[numberFormatter.currencyCode]
  }
  
  private var tickers: TickerPrice = [:] {
    didSet {
      guard let price = price else {
        return
      }
      
      processSellPrice(price)
      processBuyPrice(price)
      processSpread(price)
    }
  }
  
  private var lowestSellPrice: Decimal? {
    didSet {
      if let lowestPrice = lowestSellPrice, let stringPrice = numberFormatter.string(from: lowestPrice as NSDecimalNumber) {
        delegate?.didUpdateLowestPrice(stringPrice)
      }
    }
  }
  
  private var highestBuyPrice: Decimal? {
    didSet {
      if let highestPrice = highestBuyPrice, let stringPrice = numberFormatter.string(from: highestPrice as NSDecimalNumber) {
        delegate?.didUpdateHighestPrice(stringPrice)
      }
    }
  }
  
  private var timer: Timer?
  private lazy var numberFormatter: NumberFormatter = {
    let numberFormatter = NumberFormatter()
    numberFormatter.locale = Locale(identifier: localeIdentifier)
    numberFormatter.numberStyle = .currency
    return numberFormatter
  }()
  
  init(localeIdentifier: String, request: APIRequest = APIRequest()) {
    self.localeIdentifier = localeIdentifier
    self.request = request
    
    // Store currency symbol and clear it to remove from string convertion
    currencySymbol = numberFormatter.currencySymbol
    numberFormatter.currencySymbol = ""
  }
  
  func viewWillAppear() {
    request.delegate = self
    request.fetch()
    
    timer = Timer.scheduledTimer(withTimeInterval: pollingInterval, repeats: true) { [weak self] _ in
      self?.request.fetch()
    }
  }
  
  func viewWillDisappear() {
    timer?.invalidate()
  }
  
  // MARK: - Private methods
  
  private func decodeTickers(_ data: Data) -> TickerPrice? {
    let decoder = JSONDecoder()
    guard let tickers = try? decoder.decode(TickerPrice.self, from: data) else {
      return nil
    }
    
    return tickers
  }
  
  private func processSellPrice(_ price: Price) {
    if let sellPrice = numberFormatter.string(from: price.sell as NSDecimalNumber) {
      delegate?.didUpdateSellPrice(sellPrice,
                                   direction: priceDirection(currentPrice: price.sell, lastPrice: price.last))
    }
    
    if let lowestPrice = lowestSellPrice {
      if price.sell < lowestPrice {
        lowestSellPrice = price.sell
      }
    } else {
      lowestSellPrice = price.sell
    }
  }
  
  private func processBuyPrice(_ price: Price) {
    if let buyPrice = numberFormatter.string(from: price.buy as NSDecimalNumber) {
      delegate?.didUpdateBuyPrice(buyPrice,
                                   direction: priceDirection(currentPrice: price.buy, lastPrice: price.last))
    }
    
    if let highestPrice = highestBuyPrice {
      if price.buy > highestPrice {
        highestBuyPrice = price.buy
      }
    } else {
      highestBuyPrice = price.buy
    }
  }
  
  private func processSpread(_ price: Price) {
    if let spread = numberFormatter.string(from: (price.buy - price.sell) as NSDecimalNumber) {
      delegate?.didUpdateSpread(spread)
    }
  }
  
  private func priceDirection(currentPrice: Decimal, lastPrice: Decimal) -> PriceDirection {
    if currentPrice == lastPrice {
      return .same
    }
    
    return currentPrice > lastPrice ? .up : .down
  }
}

// MARK: - APIRequestDelegate

extension TickerViewModel: APIRequestDelegate {
  
  func didRequestComplete(_ result: Result<Data, Error>) {
    switch result {
    case .success(let data):
      if let tickers = decodeTickers(data) {
        self.tickers = tickers
      }
      
    case .failure:
      break
    }
  }
}

// MARK: - InputOrderViewDelegate

extension TickerViewModel: InputOrderViewDelegate {
  
  func didUpdateOrder(_ value: Decimal?, orderType: OrderType) {
    guard let value = value, let price = price else {
      delegate?.updateOrderConfirm(isEnabled: false)
      return
    }
    
    switch orderType {
    case .amount:
      delegate?.needToUpdateOrderUnits(price.buy / value)
      
    case .units:
      delegate?.needToUpdateOrderAmount(price.buy * value)
    }
  }
}

// MARK: - ConfirmOrderViewDelegate

extension TickerViewModel: ConfirmOrderViewDelegate {
  
  func didTapCancelButton() {
  }
  
  func didTapConfirmButton() {
  }
}
