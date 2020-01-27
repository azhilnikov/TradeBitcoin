//
//  ConfirmOrderView.swift
//  TradeBitcoin
//
//  Created by Alexey on 27/1/20.
//  Copyright © 2020 Alexey Zhilnikov. All rights reserved.
//

import UIKit

protocol ConfirmOrderViewDelegate: class {
  func didTapCancelButton()
  func didTapConfirmButton()
}

final class ConfirmOrderView: UIView {
  
  weak var delegate: ConfirmOrderViewDelegate?
  
  private let cancelButton = UIButton(type: .system)
  private let confirmButton = UIButton(type: .system)
  private let stackView = UIStackView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    configureCancelButton()
    configureConfirmButton()
    configureStackView()
    configureView()
    configureLayoutConstraints()
  }
  
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func update(isEnabled: Bool) {
    cancelButton.alpha = alphaFor(isEnabled)
    confirmButton.alpha = alphaFor(isEnabled)
    stackView.isUserInteractionEnabled = isEnabled
  }
  
  // MARK: - Private methods
  
  private func configureCancelButton() {
    configureButton(cancelButton)
    cancelButton.backgroundColor = .cancelBackground
    cancelButton.setTitle("Cancel", for: .normal)
    cancelButton.addTarget(self, action: #selector(didTapCancelButton), for: .touchUpInside)
  }
  
  private func configureConfirmButton() {
    configureButton(confirmButton)
    confirmButton.backgroundColor = .confirmBackground
    confirmButton.setTitle("Confirm", for: .normal)
    confirmButton.addTarget(self, action: #selector(didTapConfirmButton), for: .touchUpInside)
  }
  
  private func configureButton(_ button: UIButton) {
    button.setTitleColor(.white, for: .normal)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .regular)
    button.layer.cornerRadius = 8
  }
  
  private func configureStackView() {
    stackView.axis = .horizontal
    stackView.spacing = 10
    stackView.distribution = .fillEqually
    stackView.addArrangedSubview(cancelButton)
    stackView.addArrangedSubview(confirmButton)
  }
  
  private func configureView() {
    backgroundColor = .black
    addSubview(stackView)
  }
  
  private func configureLayoutConstraints() {
    layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    
    cancelButton.snp.makeConstraints { make in
      make.height.equalTo(45)
    }
    
    confirmButton.snp.makeConstraints { make in
      make.height.equalTo(45)
    }
    
    stackView.snp.makeConstraints { make in
      make.edges.equalTo(layoutMarginsGuide)
    }
  }
  
  private func alphaFor(_ isEnabled: Bool) -> CGFloat {
    return isEnabled ? 1 : 0.7
  }
  
  @objc private func didTapCancelButton() {
    delegate?.didTapCancelButton()
  }
  
  @objc private func didTapConfirmButton() {
    delegate?.didTapConfirmButton()
  }
}
