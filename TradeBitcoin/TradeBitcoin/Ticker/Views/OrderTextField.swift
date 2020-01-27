//
//  OrderTextField.swift
//  TradeBitcoin
//
//  Created by Alexey on 27/1/20.
//  Copyright © 2020 Alexey Zhilnikov. All rights reserved.
//

import UIKit

enum OrderType {
  case amount
  case units
  
  var numberStyle: NumberFormatter.Style {
    switch self {
    case .amount:
      return .currency
      
    case .units:
      return .decimal
    }
  }
}

final class OrderTextField: UITextField {
  
  var orderType: OrderType = .units
  
  private lazy var numberFormatter: NumberFormatter = {
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = orderType.numberStyle
    numberFormatter.currencySymbol = ""
    return numberFormatter
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    configureView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Private methods
  
  private func configureView() {
    backgroundColor = .textFieldBackground
    keyboardType = .numbersAndPunctuation
    borderStyle = .roundedRect
    textAlignment = .center
    layer.cornerRadius = 8
    layer.borderWidth = 1
    layer.masksToBounds = true
    delegate = self
  }
}

// MARK: - UITextFieldDelegate

extension OrderTextField: UITextFieldDelegate {
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    textField.layer.borderColor = UIColor.order.cgColor
  }
  
  func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
    textField.layer.borderColor = .none
  }
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    if string.isEmpty {
      return true
    }
    
    let newValue = (textField.text ?? "") + string
    if numberFormatter.number(from: newValue) == nil {
      return false
    }
    
    let components = newValue.components(separatedBy: numberFormatter.decimalSeparator)
    return !(components.count > 1 && components[1].count > 2)
  }
}
