//
//  CustomColor.swift
//  gud-ios
//
//  Created by sudofluff on 7/31/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

#if os(iOS)
import UIKit
typealias CustomColor = UIColor
#elseif os(OSX)
import AppKit
typealias CustomColor = NSColor
#endif

// MARK: - CustomColor

extension CustomColor {
  static var inkBlack: CustomColor { return #colorLiteral(red: 0.07843137255, green: 0.07843137255, blue: 0.07843137255, alpha: 1) }
  static var midNightBlack: CustomColor { return  #colorLiteral(red: 0.137254902, green: 0.137254902, blue: 0.137254902, alpha: 1) }
  static var transparentBlack: CustomColor { return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.75) }
  static var seaweedGreen: CustomColor { return #colorLiteral(red: 0.4470588235, green: 0.5607843137, blue: 0.2549019608, alpha: 1) }
  static var scarletCarson: CustomColor { return #colorLiteral(red: 0.5607843137, green: 0.1960784314, blue: 0.2156862745, alpha: 1) }
  static var candyWhite: CustomColor { return #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1) }
  static var offWhite: CustomColor { return #colorLiteral(red: 0.8235294118, green: 0.8235294118, blue: 0.8235294118, alpha: 1) }
  static var mandarinOrange: CustomColor { return #colorLiteral(red: 0.7411764706, green: 0.3921568627, blue: 0.2235294118, alpha: 1) }
  static var metallicGold: CustomColor { return #colorLiteral(red: 0.831372549, green: 0.6862745098, blue: 0.2156862745, alpha: 1) }
  static var deepSeaBlue: CustomColor { return #colorLiteral(red: 0.1568627451, green: 0.1725490196, blue: 0.231372549, alpha: 1) }
  static var mediumBlueGray: CustomColor { return #colorLiteral(red: 0.3294117647, green: 0.3294117647, blue: 0.368627451, alpha: 1) }
  static var mildBlueGray: CustomColor { return #colorLiteral(red: 0.4117647059, green: 0.4117647059, blue: 0.4588235294, alpha: 1) }
  static var lightBlue: CustomColor { return #colorLiteral(red: 0.9098039216, green: 0.9254901961, blue: 0.9450980392, alpha: 1) }
  static var miamiBlue: CustomColor { return #colorLiteral(red: 0, green: 0.5254901961, blue: 0.9764705882, alpha: 1) }
}
