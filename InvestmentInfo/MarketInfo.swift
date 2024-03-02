//
//  MarketInfo.swift
//  InvestmentInfo
//
//  Created by Hiroshi.Nakai on 2024/03/01.
//

import Foundation
import Alamofire
import SwiftSoup

// 市況状況
class MarketInfo {
  var name = ""
  var percent = 0.0
  var value = 0.0
  var plusOrMinus = 0.0
  
  init(name: String, percent: Double = 0.0, value: Double = 0.0, plusOrMinus: Double = 0.0){
    self.name = name
    self.percent = percent
    self.value = value
    self.plusOrMinus = plusOrMinus
  }
  
  
}
