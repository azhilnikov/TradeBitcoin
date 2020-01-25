//
//  APIErrors.swift
//  TradeBitcoin
//
//  Created by Alexey on 25/1/20.
//  Copyright © 2020 Alexey Zhilnikov. All rights reserved.
//

import Foundation

enum APIError: Error {
  case invalidURL
  case invalidResponse
  case invalidStatusCode
  case invalidData
  case invalidJSONFormat
}

extension APIError: LocalizedError {
  
  var errorDescription: String? {
    
    switch self {
    case .invalidURL:
      return NSLocalizedString("Invalid URL", comment: "")
      
    case .invalidResponse:
      return NSLocalizedString("Invalid Response", comment: "")
      
    case .invalidStatusCode:
      return NSLocalizedString("Invalid status code", comment: "")
      
    case .invalidData:
      return NSLocalizedString("Invalid data", comment: "")
      
    case .invalidJSONFormat:
      return NSLocalizedString("Invalid JSON format", comment: "")
    }
  }
}
