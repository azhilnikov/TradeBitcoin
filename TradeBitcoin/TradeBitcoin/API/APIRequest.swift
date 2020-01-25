//
//  APIRequest.swift
//  TradeBitcoin
//
//  Created by Alexey on 25/1/20.
//  Copyright © 2020 Alexey Zhilnikov. All rights reserved.
//

import Foundation

protocol APIRequestDelegate: class {
  func didRequestComplete(_ result: Result<Data, Error>)
}

class APIRequest {
  
  weak var delegate: APIRequestDelegate?
  
  private var url: URL? {
    return URL(string: "https://blockchain.info/ticker")
  }
  
  func fetch() {
    guard let url = url else {
      delegate?.didRequestComplete(.failure(APIError.invalidURL))
      return
    }
    
    let request = URLRequest(url: url,
                             cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                             timeoutInterval: 10)
    
    let session = URLSession(configuration: .default)
    session.dataTask(with: request) { (data, response, error) in
      
      DispatchQueue.main.async { [weak self] in
        if let error = error {
          self?.delegate?.didRequestComplete(.failure(error))
          return
        }
        
        guard let response = response as? HTTPURLResponse else {
          self?.delegate?.didRequestComplete(.failure(APIError.invalidResponse))
          return
        }
        
        guard (200...299).contains(response.statusCode) else {
          self?.delegate?.didRequestComplete(.failure(APIError.invalidStatusCode))
          return
        }
        
        guard let responseData = data else {
          self?.delegate?.didRequestComplete(.failure(APIError.invalidData))
          return
        }
        
        self?.delegate?.didRequestComplete(.success(responseData))
      }
    }.resume()
  }
}
