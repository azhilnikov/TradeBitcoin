//
//  SellPriceView.swift
//  TradeBitcoin
//
//  Created by Alexey on 26/1/20.
//  Copyright © 2020 Alexey Zhilnikov. All rights reserved.
//

import UIKit

let lowestPriceTitle = "L:"

final class SellPriceView: UIView {
  
  private let titleLabel = UILabel(frame: .zero)
  private let priceLabel = UILabel(frame: .zero)
  private let lowestPriceLabel = UILabel(frame: .zero)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    configureTitleLabel()
    configurePriceLabel()
    configureLowestPriceLabel()
    configureView()
    configureLayoutConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func updatePrice(_ price: String?, direction: PriceDirection) {
    priceLabel.updatePrice(price, direction: direction)
  }
  
  func updateLowestPrice(_ price: String?) {
    lowestPriceLabel.text = "\(lowestPriceTitle) \(price ?? "")"
  }
  
  // MARK: - Private methods
  
  private func configureTitleLabel() {
    titleLabel.textAlignment = .left
    titleLabel.textColor = .sellTitle
    titleLabel.font = .priceTitle
    titleLabel.text = "SELL"
    titleLabel.setContentHuggingPriority(.required, for: .vertical)
  }
  
  private func configurePriceLabel() {
    priceLabel.textAlignment = .center
    priceLabel.textColor = .defaultPrice
    priceLabel.font = .defaultPrice
    priceLabel.adjustsFontSizeToFitWidth = true
    priceLabel.minimumScaleFactor = 0.2
  }
  
  private func configureLowestPriceLabel() {
    lowestPriceLabel.textAlignment = .left
    lowestPriceLabel.textColor = .gray
    lowestPriceLabel.font = .lowestHighestPriceTitle
    lowestPriceLabel.text = lowestPriceTitle
    lowestPriceLabel.setContentHuggingPriority(.required, for: .vertical)
  }
  
  private func configureView() {
    backgroundColor = .sellBackground
    addSubview(titleLabel)
    addSubview(priceLabel)
    addSubview(lowestPriceLabel)
  }
  
  private func configureLayoutConstraints() {
    layoutMargins = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 0)
    
    titleLabel.snp.makeConstraints { make in
      make.leading.top.trailing.equalTo(layoutMarginsGuide)
    }
    
    priceLabel.snp.makeConstraints { make in
      make.leading.trailing.equalTo(layoutMarginsGuide)
      make.top.equalTo(titleLabel.snp.bottom)
    }
    
    lowestPriceLabel.snp.makeConstraints { make in
      make.top.equalTo(priceLabel.snp.bottom)
      make.leading.bottom.trailing.equalTo(layoutMarginsGuide)
    }
  }
}
