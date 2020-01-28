//
//  OrderView.swift
//  TradeBitcoin
//
//  Created by Alexey on 27/1/20.
//  Copyright © 2020 Alexey Zhilnikov. All rights reserved.
//

import UIKit

final class OrderView: UIView {
  
  private(set) lazy var unitsInputOrderView: InputOrderView = {
    return InputOrderView(viewModel: InputOrderViewModel(orderType: .units,
                                                         localeIdentifier: localeIdentifier))
  }()
  private(set) lazy var amountInputOrderView: InputOrderView = {
    return InputOrderView(viewModel: InputOrderViewModel(orderType: .amount,
                                                         localeIdentifier: localeIdentifier))
  }()
  
  private let localeIdentifier: String
  private let stackView = UIStackView()
  
  required init(localeIdentifier: String) {
    self.localeIdentifier = localeIdentifier
    super.init(frame: .zero)
    
    configureStackView()
    configureView()
    configureLayoutConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Private methods
  
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
