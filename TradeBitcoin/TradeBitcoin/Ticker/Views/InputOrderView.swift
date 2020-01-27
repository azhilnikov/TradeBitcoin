//
//  InputOrderView.swift
//  TradeBitcoin
//
//  Created by Alexey on 27/1/20.
//  Copyright © 2020 Alexey Zhilnikov. All rights reserved.
//

import UIKit

final class InputOrderView: UIStackView {
  
  private let titleLabel = UILabel()
  private let orderTextField = OrderTextField()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    configureTitleLabel()
    configureView()
  }
  
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setTitle(_ title: String) {
    titleLabel.text = title
  }
  
  func setOrderType(_ orderType: OrderType) {
    orderTextField.orderType = orderType
  }
  
  // MARK: - Private methods
  
  private func configureTitleLabel() {
    titleLabel.textAlignment = .center
    titleLabel.textColor = .order
    titleLabel.font = .systemFont(ofSize: 12)
  }
  
  private func configureView() {
    axis = .vertical
    spacing = 4
    addArrangedSubview(titleLabel)
    addArrangedSubview(orderTextField)
  }
  
  private func configureLayoutConstraint() {
    orderTextField.snp.makeConstraints { make in
      make.height.equalTo(44)
    }
  }
}
