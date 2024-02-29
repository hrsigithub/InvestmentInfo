//
//  MarketSituationView.swift
//  InvestmentInfo
//
//  Created by Hiroshi.Nakai on 2024/02/26.
//

import SwiftUI
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
          completion(nil)          }
        
      case .failure(let error):
        print(error)
        completion(nil)        }
    }
  }
  
}

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
      //let url = "https://itf.minkabu.jp/fund/9I31223A"
      //      let url = "https://nikkei225jp.com/nasdaq/"
      
      let url = "https://itf.minkabu.jp/fund/03311187"
      MarketInfo.getDoc(urlString: url) {
        doc in
        
        guard let doc = doc else {
          // ドキュメントの取得に失敗した場合の処理
          print("Failed to get document")
          return
        }

        do {
          // 日付
          let entries = try? doc.getElementsByClass("fund_cv clearfix fd_box")
          let date = try? entries?.select("span").first()?.text()
          print("DATE:\(date ?? "")")
          
           // 価格
          let stock_price = try doc.select("div.stock_price").first()?.text()
          print("stock_price:\(stock_price ?? "??")")

          //
          let entries2 = try? doc.getElementsByClass("price_diff up")
          let fprice_diff = try? entries2?.select("span").first()?.text()
          print("fprice_diff:\(fprice_diff ?? "??")")

            //
            // クラス名が "fd_estimate clearfix" の要素を選択する
            if let entries3 = try doc.getElementsByClass("fd_estimate clearfix").first() {
              // 上記の要素内の <span> 要素を選択し、そのテキストを取得する
              if let date2 = try entries3.select("span.fsm").first()?.text() {
                print("DATE2: \(date2)")
              } else {
                print("No <span> element found inside the selected element")
              }
            } else {
              print("No element with class 'fd_estimate clearfix' found")
            }

          //
          // 価格2
          let stock_price2 = try doc.select("div.stock_price").last()?.text()
          print("stock_price2:\(stock_price2 ?? "??")")

          let entries4 = try? doc.getElementsByClass("price_diff down")
          let fprice_diff2 = try? entries4?.select("span").first()?.text()
          print("fprice_diff2:\(fprice_diff2 ?? "??")")


          
          
          
        
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
        } catch {
          print("Error parsing HTML: \(error)")
        }
        
        
        
      }
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
