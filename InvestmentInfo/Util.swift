//
//  Util.swift
//  InvestmentInfo
//
//  Created by Hiroshi.Nakai on 2024/03/01.
//

import Foundation
import Alamofire
import SwiftSoup


//public func getDoc(urlString: String, completion: @escaping (Document?) -> Void) {
//  
//  guard let url = URL(string: urlString) else {
//    print("Invalid URL")
//    return
//  }
//  
//  AF.request(url).responseString { response in
//    switch response.result {
//    case .success(let htmlData):
//      print(htmlData) // HTMLコードを出力
//      do {
//        let doc = try SwiftSoup.parse(htmlData)
//        completion(doc)
//        
//      } catch {
//        print("Error parsing HTML: \(error)")
//        completion(nil)
//      }
//      
//    case .failure(let error):
//      print(error)
//      completion(nil)
//    }
//  }
//}

public func getDoc(urlString: String, completion: @escaping (Document?) -> Void) {
  
  guard let url = URL(string: urlString) else {
    print("Invalid URL")
    return
  }
  
  AF.request(url).responseData { response in
    switch response.result {
    case .success(let htmlData):
      if let htmlString = String(data: htmlData, encoding: .utf8) {
        do {
          //print(htmlString) // HTMLコードを出力
          let doc = try SwiftSoup.parse(htmlString)
          completion(doc)
        } catch {
          print("Error parsing HTML: \(error)")
          completion(nil)
        }
      } else {
        print("Failed to decode HTML data")
        completion(nil)
      }
      
    case .failure(let error):
      print(error)
      completion(nil)
    }
  }
}





public func string2Date(target: String) -> Date? {
//  print("target date: \(target)")
  
  // 日付フォーマッターを作成
  let dateFormatter = DateFormatter()
  dateFormatter.locale = Locale(identifier: "ja_JP")
  dateFormatter.timeZone = TimeZone(identifier: "Asia/Tokyo")
  dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss" // 時刻を含むフォーマットに変更
  
  // 現在の年を取得
  let currentYear = Calendar.current.component(.year, from: Date())

  // 年を追加して完全な日付文字列を作成
  let targetWithCurrentYear = "\(currentYear)/\(target) 09:00:00"

  // デバッグ情報の出力
  //print("targetWithCurrentYear date: \(targetWithCurrentYear)")
  
  // 文字列を日付型に変換
  guard let date = dateFormatter.date(from: targetWithCurrentYear) else {
    // 不正な日付の場合の処理
    print("Invalid date: \(targetWithCurrentYear)")
    return nil
  }

  // デバッグ情報の出力
//  print("Converted date: \(date)")
  
  return date
}


public func getYen(target: String) -> Int? {
  //  print("target:\(target)")
  // 正規表現パターン
  let pattern = "[^0-9]+" // 数字以外の文字をマッチさせるパターン
  
  // 正規表現によるマッチング
  guard let range = target.range(of: pattern, options: .regularExpression) else {
    print("No match found")
    return nil
  }
  
  // マッチした部分を削除して数値のみを抽出
  var numericString = target.replacingCharacters(in: range, with: "")
  
  // 円記号などの不要な文字を除去
  numericString = numericString.replacingOccurrences(of: "円", with: "")
  numericString = numericString.replacingOccurrences(of: ",", with: "")
  
  //print("numericString :\(numericString )")
  
  guard let price = Int(numericString) else {
    print("Failed to convert to integer")
    return nil
  }
  
  //print(price) // 数値のみが出力される
  return price
}


public func getDiffpersent(target: String) -> Double? {
  // 正規表現パターン
  let pattern = "\\(([-+]?\\d*\\.?\\d+)%\\)"
  
  // 正規表現によるマッチング
  guard let range = target.range(of: pattern, options: .regularExpression) else {
    print("No match found")
    return nil
  }
  
  // パーセンテージ部分を抽出
  let matchedString = target[range]
  
  // マッチした部分からパーセンテージを取得
  guard let percentRange = matchedString.range(of: "[-+]?\\d*\\.?\\d+", options: .regularExpression) else {
    print("Failed to extract percent")
    return nil
  }
  
  let percentString = matchedString[percentRange]
  
  // パーセンテージを Double に変換して返す
  if let percent = Double(percentString) {
    //print("Percent: \(percent)") // パーセンテージ部分を数値として出力
    return percent
  } else {
    print("Failed to convert to Double")
    return nil
  }
}
