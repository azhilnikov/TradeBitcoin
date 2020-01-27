//
//  InputOrderView.swift
//  TradeBitcoin
//
//  Created by Alexey on 27/1/20.
//  Copyright © 2020 Alexey Zhilnikov. All rights reserved.
//

import UIKit

protocol InputOrderViewDelegate: class {
  func didUpdateOrder(_ value: Decimal?, orderType: OrderType)
}

final class InputOrderView: UIView {
  
  weak var delegate: InputOrderViewDelegate?
  
  private let viewModel: InputOrderViewModel
  private let titleLabel = UILabel()
  private let textField = UITextField()
  private let stackView = UIStackView()
  
  required init(viewModel: InputOrderViewModel) {
    self.viewModel = viewModel
    super.init(frame: .zero)
    
    configureTitleLabel()
    configureOrderTextField()
    configureStackView()
    configureView()
    configureLayoutConstraint()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setTitle(_ title: String) {
    titleLabel.text = title
  }
  
  func update(_ value: Decimal?) {
    textField.text = viewModel.string(from: value)
  }
  
  // MARK: - Private methods
  
  private func configureTitleLabel() {
    titleLabel.textAlignment = .center
    titleLabel.textColor = .order
    titleLabel.font = .systemFont(ofSize: 12)
  }
  
  private func configureOrderTextField() {
    textField.backgroundColor = .textFieldBackground
    textField.keyboardType = .numbersAndPunctuation
    textField.borderStyle = .roundedRect
    textField.autocorrectionType = .no
    textField.textAlignment = .center
    textField.layer.cornerRadius = 8
    textField.layer.borderWidth = 1
    textField.layer.masksToBounds = true
    textField.delegate = self
  }
  
  private func configureStackView() {
    stackView.axis = .vertical
    stackView.spacing = 4
    stackView.addArrangedSubview(titleLabel)
    stackView.addArrangedSubview(textField)
  }
  
  private func configureView() {
    addSubview(stackView)
  }
  
  private func configureLayoutConstraint() {
    textField.snp.makeConstraints { make in
      make.height.equalTo(44)
    }
    
    stackView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
}

extension InputOrderView: UITextFieldDelegate {

  func textFieldDidBeginEditing(_ textField: UITextField) {
    textField.layer.borderColor = UIColor.order.cgColor
  }

  func textFieldDidEndEditing(_ textField: UITextField) {
    textField.layer.borderColor = .none
  }
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    return viewModel.shouldChangeValue(textField.text, newValue: string)
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    delegate?.didUpdateOrder(viewModel.valueOf(textField.text), orderType: viewModel.orderType)
    return true
  }
}
