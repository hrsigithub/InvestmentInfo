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
  
  static func getDoc(urlString: String, completion: @escaping (Document?) -> Void) {
    
    guard let url = URL(string: urlString) else {
      print("Invalid URL")
      return
    }
    
    AF.request(url).responseString { response in
      switch response.result {
      case .success(let html):
        //print(html) // HTMLコードを出力
        do {
          let doc = try SwiftSoup.parse(html)
          completion(doc)
          
        } catch {
          print("Error parsing HTML: \(error)")
          completion(nil)
        }
        
      case .failure(let error):
        print(error)
        completion(nil)
      }
    }
  }
  
}
