//
//  TickerViewController.swift
//  TradeBitcoin
//
//  Created by Alexey on 25/1/20.
//  Copyright © 2020 Alexey Zhilnikov. All rights reserved.
//

import UIKit
import SnapKit

final class TickerViewController: UIViewController {
  
  private let viewModel: TickerViewModel
  private let priceView = PriceView()
  private let spreadLabel = UILabel()
  private let orderView = OrderView()
  private let confirmOrderView = ConfirmOrderView()
  
  init(viewModel: TickerViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
    self.viewModel.delegate = self
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureSpreadLabel()
    configureOrderView()
    configureConfirmOrderView()
    configureView()
    configureLayoutConstraints()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    viewModel.viewWillAppear()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    viewModel.viewWillDisappear()
  }
  
  // MARK: - Private methods
  
  private func configureSpreadLabel() {
    spreadLabel.textAlignment = .center
    spreadLabel.textColor = .white
    spreadLabel.font = .spread
  }
  
  private func configureOrderView() {
    orderView.unitsInputOrderView.setTitle("Units")
    orderView.unitsInputOrderView.delegate = viewModel
    
    orderView.amountInputOrderView.setTitle("Amount (\(viewModel.currencySymbol ?? ""))")
    orderView.amountInputOrderView.delegate = viewModel    
  }
  
  private func configureConfirmOrderView() {
    confirmOrderView.update(isEnabled: false)
    confirmOrderView.delegate = viewModel
  }
  
  private func configureView() {
    view.backgroundColor = .background
    view.addSubview(priceView)
    priceView.addSubview(spreadLabel)
    view.addSubview(orderView)
    view.addSubview(confirmOrderView)
  }
  
  private func configureLayoutConstraints() {
    priceView.snp.makeConstraints { make in
      make.leading.top.trailing.equalTo(view.safeAreaLayoutGuide)
      make.height.equalTo(100)
    }
    
    spreadLabel.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.bottom.equalToSuperview().inset(4)
    }
    
    orderView.snp.makeConstraints { make in
      make.top.equalTo(priceView.snp.bottom)
      make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
    }
    
    confirmOrderView.snp.makeConstraints { make in
      make.leading.bottom.trailing.equalTo(view.safeAreaLayoutGuide)
    }
  }
}

extension TickerViewController: TickerViewModelDelegate {
  
  func didUpdateSellPrice(_ price: String?, direction: PriceDirection) {
    priceView.sellPriceView.updatePrice(price, direction: direction)
  }
  
  func didUpdateBuyPrice(_ price: String?, direction: PriceDirection) {
    priceView.buyPriceView.updatePrice(price, direction: direction)
  }
  
  func didUpdateSpread(_ spread: String?) {
    spreadLabel.text = spread
  }
  
  func didUpdateLowestPrice(_ price: String?) {
    priceView.sellPriceView.updateLowestPrice(price)
  }
  
  func didUpdateHighestPrice(_ price: String?) {
    priceView.buyPriceView.updateHighestPrice(price)
  }
  
  func needToUpdateOrderUnits(_ units: Decimal?) {
    orderView.unitsInputOrderView.update(units)
  }
  
  func needToUpdateOrderAmount(_ amount: Decimal?) {
    orderView.amountInputOrderView.update(amount)
  }
  
  func updateOrderConfirm(isEnabled: Bool) {
    confirmOrderView.update(isEnabled: isEnabled)
  }
}
