//
//  UpdatePrice.swift
//  TradeBitcoin
//
//  Created by Alexey on 26/1/20.
//  Copyright © 2020 Alexey Zhilnikov. All rights reserved.
//

import Foundation

enum UpdatePriceDirection {
  case up
  case down
}

protocol UpdatePrice {
  func updatePrice(_ price: String, direction: UpdatePriceDirection)
}
