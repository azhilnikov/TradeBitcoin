//
//  OrderView.swift
//  TradeBitcoin
//
//  Created by Alexey on 27/1/20.
//  Copyright © 2020 Alexey Zhilnikov. All rights reserved.
//

import UIKit

final class OrderView: UIView {
  
  let unitsInputOrderView = InputOrderView()
  let amountInputOrderView = InputOrderView()
  
  private let stackView = UIStackView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    configureUnitsInputOrderView()
    configureAmountInputOrderView()
    configureStackView()
    configureView()
    configureLayoutConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Private methods
  
  private func configureUnitsInputOrderView() {
    unitsInputOrderView.setOrderType(.units)
  }
  
  private func configureAmountInputOrderView() {
    amountInputOrderView.setOrderType(.amount)
  }
  
  private func configureStackView() {
    stackView.axis = .horizontal
    stackView.spacing = 10
    stackView.distribution = .fillEqually
    stackView.addArrangedSubview(unitsInputOrderView)
    stackView.addArrangedSubview(amountInputOrderView)
  }
  
  
  private func configureView() {
    backgroundColor = .black
    addSubview(stackView)
  }
  
  private func configureLayoutConstraints() {
    layoutMargins = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
    
    stackView.snp.makeConstraints { make in
      make.edges.equalTo(layoutMarginsGuide)
    }
  }
}