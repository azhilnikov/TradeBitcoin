//
//  OrderType.swift
//  TradeBitcoin
//
//  Created by Alexey on 27/1/20.
//  Copyright © 2020 Alexey Zhilnikov. All rights reserved.
//

import Foundation

enum OrderType {
  case amount
  case units
  
  var numberStyle: NumberFormatter.Style {
    switch self {
    case .amount:
      return .currency
      
    case .units:
      return .decimal
    }
  }
}
