//
//  StringProtocol+Extension.swift
//  Space44Test
//
//  Created by Chukwuebuka Nwudo on 13/12/2021.
//

import Foundation

extension StringProtocol {
  var firstUppercased: String {
    return prefix(1).uppercased() + dropFirst()
  }

  var displayNicely: String {
    return firstUppercased.replacingOccurrences(of: "_", with: " ")
  }
}
