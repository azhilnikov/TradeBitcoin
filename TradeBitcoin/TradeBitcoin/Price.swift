//
//  Price.swift
//  TradeBitcoin
//
//  Created by Alexey on 25/1/20.
//  Copyright © 2020 Alexey Zhilnikov. All rights reserved.
//

import Foundation

struct Price: Decodable {
  
  let last: Decimal
  let buy: Decimal
  let sell: Decimal
  let symbol: String
  
  private enum CodingKeys: String, CodingKey {
    case last
    case buy
    case sell
    case symbol
  }
  
  init(from decoder: Decoder) throws {
    do {
      let container = try decoder.container(keyedBy: CodingKeys.self)
      self.last = try container.decode(Decimal.self, forKey: .last)
      self.buy = try container.decode(Decimal.self, forKey: .buy)
      self.sell = try container.decode(Decimal.self, forKey: .sell)
      self.symbol = try container.decode(String.self, forKey: .symbol)
    } catch {
      throw error
    }
  }
}
