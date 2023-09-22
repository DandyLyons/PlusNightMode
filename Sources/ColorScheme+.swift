//
//  File.swift
//  
//
//  Created by Daniel Lyons on 9/22/23.
//

import SwiftUI

extension ColorScheme: CustomDebugStringConvertible {
  public var debugDescription: String {
    switch self {
      case .light:
        ".light"
      case .dark:
        ".dark"
      @unknown default: "@unknown default"
    }
  }
}
