//
//  Util.swift
//  InvestmentInfo
//
//  Created by Hiroshi.Nakai on 2024/03/01.
//

import Foundation

public func string2Date(target: String) -> Date? {
  // 日付フォーマッターを作成
  let f = DateFormatter()
  /// カレンダー、ロケール、タイムゾーンの設定（未指定時は端末の設定が採用される）
  f.calendar = Calendar(identifier: .gregorian)
  f.locale = Locale(identifier: "ja_JP")
//  f.timeZone = TimeZone(identifier:  "Asia/Tokyo")
  f.timeZone = TimeZone.autoupdatingCurrent
  f.dateFormat = "yyyy/MM/dd" // 日付文字列の形式に合わせる
  
  // 現在の年を取得
  let currentYear = Calendar.current.component(.year, from: Date())
  let target2 = "03/01"
  let targetWithCurrentYear = "\(currentYear)/\(target2)" // 02/29/2024 などの形式に変換
  
  print("target:--> OK? \(target)")
  print("targetWithCurrentYear:--> OK? \(targetWithCurrentYear)")
  
  // 文字列を日付型に変換
  if let date = f.date(from: targetWithCurrentYear) {
    print("date:--> OK? \(date)")

    return date
  } else {
    print("Invalid date: \(targetWithCurrentYear)")
    return nil
  }
//  // 文字列を日付型に変換
//  if let date = f.date(from: targetWithCurrentYear) {
//    // うるう年であるかどうかを確認
//    let calendar = Calendar.current
//    let isLeapYear = calendar.isDateInLeapYear(date: date)
//    if isLeapYear {
//      // うるう年であれば、そのまま日付を返す
//      return date
//    } else {
//      // うるう年でない場合は、無効な日付として扱う
//      print("Invalid date: \(targetWithCurrentYear) is not a leap year")
//      return nil
//    }
//  } else {
//    // 日付が無効な場合は、そのまま nil を返す
//    print("Invalid date: \(targetWithCurrentYear)")
//    return nil
//  }
}

extension Calendar {
  func isDateInLeapYear(date: Date) -> Bool {
    let year = self.component(.year, from: date)
    return (year % 4 == 0 && year % 100 != 0) || year % 400 == 0
  }
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
