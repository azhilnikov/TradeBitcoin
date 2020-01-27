//
//  InputOrderViewModel.swift
//  TradeBitcoin
//
//  Created by Alexey on 27/1/20.
//  Copyright © 2020 Alexey Zhilnikov. All rights reserved.
//

import Foundation

final class InputOrderViewModel {
  
  let orderType: OrderType
  
  private lazy var numberFormatter: NumberFormatter = {
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = orderType.numberStyle
    numberFormatter.maximumFractionDigits = 2
    numberFormatter.currencySymbol = ""
    return numberFormatter
  }()
  
  init(orderType: OrderType) {
    self.orderType = orderType
  }
  
  func shouldChange(_ currentValue: String?, by newValue: String) -> Bool {
    if newValue.isEmpty {
      return true
    }
    
    let value = (currentValue ?? "") + newValue
    if numberFormatter.number(from: value) == nil {
      return false
    }

    let components = value.components(separatedBy: numberFormatter.decimalSeparator)
    return !(components.count > 1 && components[1].count > 2)
  }
  
  func valueOf(_ text: String?) -> Decimal? {
    let value = numberFormatter.number(from: text ?? "")
    return value?.decimalValue
  }
  
  func string(from value: Decimal?) -> String? {
    guard let value = value else {
      return nil
    }
    
    return numberFormatter.string(from: value as NSDecimalNumber)
  }
}
