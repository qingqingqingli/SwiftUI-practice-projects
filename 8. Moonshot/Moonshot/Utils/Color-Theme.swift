//
//  Color-Theme.swift
//

import Foundation
import SwiftUI

// add functionality to ShapeStyle, but only for times when it's used as a color
// this allows us to use those colors everywhere SwiftUI expects a ShapeStyle
extension ShapeStyle where Self == Color {
    static var darkBackground: Color {
        Color(red: 0.1, green: 0.1, blue: 0.2)
    }
    
    static var lightBackground: Color {
        Color(red: 0.2, green: 0.2, blue: 0.3)
    }
    
}
