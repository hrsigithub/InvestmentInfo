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
  
  // 前日比
  var beforeRatioValue = 0.0
  var beforeRatioPercent = 0.0
  
  static func getSp500(completion: @escaping (MarketInfo?) -> Void) {
    let url = "https://finance.yahoo.co.jp/quote/%5EGSPC"
    
    getDoc(urlString: url) {
      doc in
      
      guard let doc = doc else {
        // ドキュメントの取得に失敗した場合の処理
        print("Failed to get document")
        completion(nil)
        return
      }
      let data = MarketInfo()
      
      do {
        guard let nameElement = try? doc.getElementsByClass("Pz3gXPTn").first() else {
          print("Failed to retrieve name entries")
          return
        }
        let name = try nameElement.text()
        print(name)
        data.name = name
        
        guard let valueElement = try? doc.getElementsByClass("_3BGK5SVf").first() else {
          print("Failed to retrieve value entries")
          return
        }
        guard let stringValue = try? valueElement.text().replacingOccurrences(of: ",", with: "") else {
          print("Failed to retrieve value text")
          return
        }
        guard let doubleValue = Double(stringValue) else {
          print("Failed to convert text to Double")
          return
        }
        
        data.value = doubleValue
        print("Value: \(data.value)")
        
      } catch {
        print("Error parsing HTML: \(error)")
        completion(nil)
      }

      
    }
    
  }
  
  
}
