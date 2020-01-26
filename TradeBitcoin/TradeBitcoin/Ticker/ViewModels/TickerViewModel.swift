//
//  TickerViewModel.swift
//  TradeBitcoin
//
//  Created by Alexey on 25/1/20.
//  Copyright © 2020 Alexey Zhilnikov. All rights reserved.
//

import Foundation

typealias TickerPrice = [String: Price]

final class TickerViewModel {
  
  private let localeIdentifier: String
  private let request: APIRequest
  private let pollingInterval: TimeInterval = 15
  
  private(set) var currencySymbol: String?
  
  private var tickers: TickerPrice = [:] {
    didSet {
      guard let price = tickers[numberFormatter.currencyCode] else {
        return
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
}

extension TickerViewModel: APIRequestDelegate {
  
  func didRequestComplete(_ result: Result<Data, Error>) {
    switch result {
    case .success(let data):
      if let tickers = decodeTickers(data) {
        self.tickers = tickers
      }
      
    case .failure(let error):
      break
    }
  }
}
