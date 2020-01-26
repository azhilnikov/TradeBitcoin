//
//  UILabelExtention.swift
//  TradeBitcoin
//
//  Created by Alexey on 26/1/20.
//  Copyright © 2020 Alexey Zhilnikov. All rights reserved.
//

import UIKit

extension UILabel {
  
  func updatePrice(_ price: String, direction: UpdatePriceDirection) {
    let attributedString = NSMutableAttributedString(string: price)
    
    let dotRange = (price as NSString).range(of: ".")
    if dotRange.location != NSNotFound {
      let fractionRange = NSRange(location: dotRange.location + 1, length: price.count - dotRange.location - 1)
      attributedString.addAttributes([.font: UIFont.defaultFractionPrice], range: fractionRange)
    }
    
    attributedText = attributedString
    
    switch direction {
    case .up:
      highlightPrice(color: .upPrice)
      
    case .down:
      highlightPrice(color: .downPrice)
    }
  }
  
  private func highlightPrice(color: UIColor) {
    textColor = color
    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: { [weak self] in
      self?.textColor = .defaultPrice
    })
  }
}
