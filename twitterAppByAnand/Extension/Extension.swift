//
//  Extension.swift
//  twitterAppByAnand
//
//  Created by APPLE on 15/11/23.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

func highlightMentions(in text: String, withColor color: UIColor) -> NSAttributedString {
      let attributedString = NSMutableAttributedString(string: text)

      do {
          let regex = try NSRegularExpression(pattern: "\\B@\\w+", options: [])
          let matches = regex.matches(in: text, options: [], range: NSRange(location: 0, length: text.utf16.count))

          for match in matches {
              let matchRange = match.range(at: 0)
              attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: matchRange)
          }
      } catch {
          print("Error creating regular expression: \(error)")
      }

      return attributedString
  }

