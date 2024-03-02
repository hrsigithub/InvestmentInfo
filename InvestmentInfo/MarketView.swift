//
//  MarketSituationView.swift
//  InvestmentInfo
//
//  Created by Hiroshi.Nakai on 2024/02/26.
//

import SwiftUI
import Alamofire
import SwiftSoup


struct MarketView: View {
  private let sp500 =
  MarketInfo(name: "S&P500", percent:0.03, value:5088.80, plusOrMinus: 1.77)
  
  var body: some View {
    ZStack {
      Rectangle()
        .fill(Color(red: 95/255, green: 95/255, blue: 95/255)) // 背景色を指定
        .frame(width: 370, height: 75)
      
      VStack {
        HStack {
          Text(sp500.name)
            .padding(10)
            .background(Color(red:95/255, green: 95/255, blue: 95/255))
            .foregroundColor(Color(red:159/255, green:219/255, blue:228/255))
          
          Text("🔼" + String(format: "%.2f", sp500.percent) + "%")
            .padding(10)
            .background(Color(red:219/255, green: 223/255, blue: 221/255))
          
          // +
            .foregroundColor(Color(red:65/255, green:167/255, blue:65/255))
          
          
          Text(String(format: "%.2f", sp500.value))
            .padding(10)
            .background(Color(red:219/255, green: 223/255, blue: 221/255))
            .foregroundColor(Color(red:142/255, green:142/255, blue:142/255))
          
          Text(String(format: "%.2f", sp500.plusOrMinus) + "%")
            .padding(10)
            .background(Color(red:219/255, green: 223/255, blue: 221/255))
            .foregroundColor(Color(red:65/255, green:167/255, blue:65/255))
          
        }
      }
    }.task {
      print("表示したでえ")
      MinkabuInfo.getEmaxSlimSP500() { data in
        guard let data = data else {
          // データの取得に失敗した場合の処理
          print("Failed to get data")
          return
        }
        
        // 取得したデータを使用して何かしらの処理を行う
        print("Date: \(data.info.date)")
        print("Price: \(data.info.price)")
        print("Price Diff: \(data.info.priceDiff)")
        print("Estimated Date: \(data.estimate?.date)")
        print("Estimated Price: \(data.estimate?.price)")
        print("Estimated Price Diff: \(data.estimate?.priceDiff)")
      }

              





          
          
          
        
//        // NAME
//        guard let entries = try? doc.select("p.THp.TcolN") else {
//          print("Failed to select entries")
//          return
//        }
//        
//        // SP500
//        guard let entry = entries[safe: 3] else {
//          print("Entry at index 2 not found")
//          return
//        }
//        
//        guard let name = try? entry.text() else {
//          print("Failed to get name")
//          return
//        }
//        print("Name: \(name)")
        //
        // Value
        
          
//          if let divElement = try doc.select("div.stock_price").first(),
//
//              
//              let pElement = try divElement.select("p").first() {
//            // divElementとpElementを印刷する
//            print("divElement: \(try divElement.outerHtml())")
//            // print("pElement: \(try pElement.outerHtml())")
//            
//            let text = try pElement.text()
//            //print("Text inside <p>: \(text)") // "5,084.25" が出力される
//          } else {
//            print("No matching <div> or <p> element found")
//          }
//        } catch {
//          print("Error parsing HTML: \(error)")
//        }
        
        
        
      //}
    }
  }
  
  
  
  
}


extension Collection {
  subscript(safe index: Index) -> Element? {
    return indices.contains(index) ? self[index] : nil
  }
}


#Preview {
  MarketView()
}
