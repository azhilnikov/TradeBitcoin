//
//  PriceView.swift
//  TradeBitcoin
//
//  Created by Alexey on 26/1/20.
//  Copyright © 2020 Alexey Zhilnikov. All rights reserved.
//

import UIKit

final class PriceView: UIStackView {
  
  let sellPriceView = SellPriceView()
  let buyPriceView = BuyPriceView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    configureView()
    configureTapGestureRecognizer()
  }
  
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Private methods
  
  private func configureView() {
    axis = .horizontal
    distribution = .fillEqually
    
    addArrangedSubview(sellPriceView)
    addArrangedSubview(buyPriceView)
  }
  
  private func configureTapGestureRecognizer() {
    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapHandler))
    addGestureRecognizer(tapGestureRecognizer)
  }
  
  @objc private func tapHandler(_ sender: UITapGestureRecognizer) {
    let tapLocation = sender.location(in: self)
    sellPriceView.frame.contains(tapLocation)
    buyPriceView.frame.contains(tapLocation)
  }
}
