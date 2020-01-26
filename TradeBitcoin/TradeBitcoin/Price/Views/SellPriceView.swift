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
  
  // MARK: - Private methods
  
  private func configureTitleLabel() {
    titleLabel.textAlignment = .left
    titleLabel.textColor = .sellTitle
    titleLabel.font = .systemFont(ofSize: 12)
    titleLabel.text = "SELL"
    titleLabel.setContentHuggingPriority(.required, for: .vertical)
  }
  
  private func configurePriceLabel() {
    priceLabel.textAlignment = .center
    priceLabel.textColor = .defaultPrice
    priceLabel.font = .systemFont(ofSize: 30)
    priceLabel.adjustsFontSizeToFitWidth = true
    priceLabel.minimumScaleFactor = 0.2
  }
  
  private func configureLowestPriceLabel() {
    lowestPriceLabel.textAlignment = .left
    lowestPriceLabel.textColor = .gray
    lowestPriceLabel.font = .systemFont(ofSize: 13)
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
    titleLabel.snp.makeConstraints { make in
      make.leading.top.trailing.equalToSuperview()
    }
    
    priceLabel.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview()
      make.top.equalTo(titleLabel.snp.bottom)
    }
    
    lowestPriceLabel.snp.makeConstraints { make in
      make.top.equalTo(priceLabel.snp.bottom)
      make.leading.bottom.trailing.equalToSuperview()
    }
  }
}

extension SellPriceView: UpdatePrice {
  
  func updatePrice(_ price: String, direction: UpdatePriceDirection) {
    priceLabel.updatePrice(price, direction: direction)
  }
}
