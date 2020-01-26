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
  
  private func configureView() {
    view.backgroundColor = .background
    view.addSubview(priceView)
    priceView.addSubview(spreadLabel)
  }
  
  private func configureLayoutConstraints() {
    priceView.snp.makeConstraints { make in
      make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
      make.height.equalTo(100)
    }
    
    spreadLabel.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.bottom.equalToSuperview().inset(4)
    }
  }
}

extension TickerViewController: TickerViewModelDelegate {
  
  func didUpdateSellPrice(_ price: String, direction: PriceDirection) {
    priceView.sellPriceView.updatePrice(price, direction: direction)
  }
  
  func didUpdateBuyPrice(_ price: String, direction: PriceDirection) {
    priceView.buyPriceView.updatePrice(price, direction: direction)
  }
  
  func didUpdateSpread(_ spread: String) {
    spreadLabel.text = spread
  }
  
  func didUpdateLowestPrice(_ price: String) {
    priceView.sellPriceView.updateLowestPrice(price)
  }
  
  func didUpdateHighestPrice(_ price: String) {
    priceView.buyPriceView.updateHighestPrice(price)
  }
}
