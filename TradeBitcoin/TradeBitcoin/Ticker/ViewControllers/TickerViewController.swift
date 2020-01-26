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
  
  init(viewModel: TickerViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
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
  
  private func configureView() {
    view.backgroundColor = .background
    view.addSubview(priceView)
  }
  
  private func configureLayoutConstraints() {
    priceView.snp.makeConstraints { make in
      make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
      make.height.equalTo(100)
    }
  }
}
