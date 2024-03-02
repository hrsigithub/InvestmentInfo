//
//  MinkabuInfo.swift
//  InvestmentInfo
//
//  Created by Hiroshi.Nakai on 2024/03/01.
//

import Foundation
import Alamofire
import SwiftSoup

// ミンカブ
class PriceInfo {
  var date: Date?
  var price = 0
  var priceDiff = 0.0
}

class MinkabuInfo {
  var name = ""
  var info = PriceInfo()
  var estimate :PriceInfo?
  
  
  static func getEmaxSlimSP500(completion: @escaping (MinkabuInfo?) -> Void) {
    let url = "https://itf.minkabu.jp/fund/03311187"
    
    MarketInfo.getDoc(urlString: url) {
      doc in
      
      guard let doc = doc else {
        // ドキュメントの取得に失敗した場合の処理
        print("Failed to get document")
        completion(nil)
       return
      }
      let data = MinkabuInfo()
      
      do {
        // 日付
        let entries = try? doc.getElementsByClass("fund_cv clearfix fd_box")
        let date = try? entries?.select("span").first()?.text()
        //print("DATE:\(date ?? "")")
        
        data.info.date = string2Date(target: date ?? "")

        // 価格
        data.info.price = getYen(target: try doc.select("div.stock_price").first()?.text() ?? "") ?? 0

        //　上げ幅
        let priceDiff = try? doc.getElementsByClass("price_diff up").select("span").first()?.text()
        data.info.priceDiff = getDiffpersent(target: priceDiff ?? "") ?? 0.0

        data.estimate = PriceInfo()
        guard let entries3 = try? doc.getElementsByClass("fd_estimate clearfix").first() else {
          print("No element with class 'fd_estimate clearfix' found")
          return
        }
        
        guard let estimatedate = try? entries3.select("span.fsm").first()?.text() else {
          print("No <span> element found inside the selected element")
          return
        }
        
        data.estimate?.date = string2Date(target: estimatedate)
        data.estimate?.price = getYen(target: try doc.select("div.stock_price").last()?.text() ?? "") ?? 0

        

        // 完了ブロックにデータを渡す
        completion(data)
      }
      catch {
        print("Error parsing HTML: \(error)")
        completion(nil)
      }
    }
  }
}

