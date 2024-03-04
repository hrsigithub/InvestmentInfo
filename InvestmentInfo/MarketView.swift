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
  //  private let sp500 =
  //  MarketInfo(name: "S&P500", percent:0.03, value:5088.80, plusOrMinus: 1.77)
  
  var body: some View {
    ZStack {
      Rectangle()
        .fill(Color(red: 95/255, green: 95/255, blue: 95/255)) // 背景色を指定
        .frame(width: 370, height: 75)
      
      VStack {
        HStack {
          Text("")
            .padding(10)
            .background(Color(red:95/255, green: 95/255, blue: 95/255))
            .foregroundColor(Color(red:159/255, green:219/255, blue:228/255))
          
          Text("🔼" + String(format: "%.2f", 3) + "%")
            .padding(10)
            .background(Color(red:219/255, green: 223/255, blue: 221/255))
          
          // +
            .foregroundColor(Color(red:65/255, green:167/255, blue:65/255))
          
          
          Text(String(format: "%.2f", ""))
            .padding(10)
            .background(Color(red:219/255, green: 223/255, blue: 221/255))
            .foregroundColor(Color(red:142/255, green:142/255, blue:142/255))
          
          Text(String(format: "%.2f", 0.3) + "%")
            .padding(10)
            .background(Color(red:219/255, green: 223/255, blue: 221/255))
            .foregroundColor(Color(red:65/255, green:167/255, blue:65/255))
          
        }
      }
    }.task {
      print("表示したでえ")
      
      MarketInfo.getSp500() {  data in
        guard let data = data else {
          // データの取得に失敗した場合の処理
          print("Failed to get data")
          return
        }
        
        // 取得したデータを使用して何かしらの処理を行う
        print("Name: \(String(describing: data.name))")

        
      }
      
      
      
//      MinkabuInfo.getEmaxSlimSP500() { data in
//        guard let data = data else {
//          // データの取得に失敗した場合の処理
//          print("Failed to get data")
//          return
//        }
//        
//        // 取得したデータを使用して何かしらの処理を行う
//        print("Date: \(String(describing: data.info.date))")
//        print("Price: \(data.info.price)")
//        print("Price Diff: \(data.info.priceDiff)")
//        print("Estimated Date: \(String(describing: data.estimate?.date))")
//        print("Estimated Price: \(String(describing: data.estimate?.price))")
//        print("Estimated Price Diff: \(String(describing: data.estimate?.priceDiff))")
//      }
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
