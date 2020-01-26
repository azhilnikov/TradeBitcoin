//
//  BuyPriceView.swift
//  TradeBitcoin
//
//  Created by Alexey on 26/1/20.
//  Copyright © 2020 Alexey Zhilnikov. All rights reserved.
//

import UIKit

let highestPriceTitle = "H:"

final class BuyPriceView: UIView {
  
  private let titleLabel = UILabel(frame: .zero)
  private let priceLabel = UILabel(frame: .zero)
  private let highestPriceLabel = UILabel(frame: .zero)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    configureTitleLabel()
    configurePriceLabel()
    configureHighestPriceLabel()
    configureView()
    configureLayoutConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func updatePrice(_ price: String, direction: PriceDirection) {
    priceLabel.updatePrice(price, direction: direction)
  }
  
  func updateHighestPrice(_ price: String) {
    highestPriceLabel.text = "\(highestPriceTitle) \(price)"
  }
  
  // MARK: - Private methods
  
  private func configureTitleLabel() {
    titleLabel.textAlignment = .right
    titleLabel.textColor = .buyTitle
    titleLabel.font = .systemFont(ofSize: 12)
    titleLabel.text = "BUY"
    titleLabel.setContentHuggingPriority(.required, for: .vertical)
  }
  
  private func configurePriceLabel() {
    priceLabel.textAlignment = .center
    priceLabel.textColor = .defaultPrice
    priceLabel.font = .defaultPrice
    priceLabel.adjustsFontSizeToFitWidth = true
    priceLabel.minimumScaleFactor = 0.2
  }
  
  private func configureHighestPriceLabel() {
    highestPriceLabel.textAlignment = .right
    highestPriceLabel.textColor = .gray
    highestPriceLabel.font = .systemFont(ofSize: 13)
    highestPriceLabel.text = highestPriceTitle
    highestPriceLabel.setContentHuggingPriority(.required, for: .vertical)
  }
  
  private func configureView() {
    backgroundColor = .buyBackground
    addSubview(titleLabel)
    addSubview(priceLabel)
    addSubview(highestPriceLabel)
  }
  
  private func configureLayoutConstraints() {
    titleLabel.snp.makeConstraints { make in
      make.leading.top.trailing.equalToSuperview()
    }
    
    priceLabel.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview()
      make.top.equalTo(titleLabel.snp.bottom)
    }
    
    highestPriceLabel.snp.makeConstraints { make in
      make.top.equalTo(priceLabel.snp.bottom)
      make.leading.bottom.trailing.equalToSuperview()
    }
  }
}
