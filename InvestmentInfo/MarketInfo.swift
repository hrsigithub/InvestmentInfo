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
  var closingPrice = 0.0
  var transactionDate = Date().addingTimeInterval(-24 * 60 * 60) // 24時間前の日付
  
  // 前日比
  var theDayBeforeRatio = 0.0
  var previousDayRatio = 0.0
  
  
  static func getSp500(completion: @escaping (MarketInfo?) -> Void) {
    let url = "https://finance.yahoo.co.jp/quote/%5EGSPC"
    
    getDoc(urlString: url) {
      doc in
      
      guard let doc = doc else {
        print("Failed to get document")
        completion(nil)
        return
      }
      let data = MarketInfo()
      
      do {
        data.name = try doc.getElementsByClass("Pz3gXPTn").first()?.text() ?? "NG-NAME"
        print(data.name)
        
        guard let valueElements = try? doc.getElementsByClass("_3BGK5SVf") else {
          print("Failed to retrieve value entries")
          return
        }
        
        // 前日値
        guard let stringValue = try? valueElements[0].text().replacingOccurrences(of: ",", with: "") else {
          print("Failed to retrieve value text")
          return
        }
        
        guard let doubleValue = Double(stringValue) else {
          print("Failed to convert text to Double")
          return
        }
        data.closingPrice = doubleValue
        print(data.closingPrice)
        
        // 前日比
        guard let stringValue = try? valueElements[1].text() else {
          print("Failed to retrieve value text")
          return
        }
        guard let doubleValue = Double(stringValue) else {
          print("Failed to convert text to Double")
          return
        }
        
        
        data.theDayBeforeRatio = doubleValue
        print(data.theDayBeforeRatio)
        
        
        
      } catch {
        print("Error parsing HTML: \(error)")
        completion(nil)
      }
      
      
    }
    
  }
  
  
  
}
