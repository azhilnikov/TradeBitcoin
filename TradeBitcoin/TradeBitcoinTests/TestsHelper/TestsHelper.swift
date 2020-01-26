//
//  TestsHelper.swift
//  TradeBitcoinTests
//
//  Created by Alexey on 26/1/20.
//  Copyright © 2020 Alexey Zhilnikov. All rights reserved.
//

import Foundation

class TestsHelper {
  
  class func loadData(from fileName: String) -> Data? {
    guard let url = Bundle(for: TestsHelper.self).url(forResource: fileName, withExtension: "json") else {
      return nil
    }
    
    guard let data = try? Data(contentsOf: url) else { return nil }
    return data
  }
}
