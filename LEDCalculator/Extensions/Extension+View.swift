//
//  Extension+View.swift
//  LEDCalculator
//
//  Created by Wayne Dahlberg on 10/7/24.
//

import SwiftUI

extension View {
  func border(_ color: Color, width: CGFloat, edges: Edge.Set) -> some View {
    overlay(EdgeBorder(width: width, edges: edges).foregroundColor(color))
  }
}

struct EdgeBorder: Shape {
  var width: CGFloat
  var edges: Edge.Set
  
  func path(in rect: CGRect) -> Path {
    var path = Path()
    
    if edges.contains(.top) || edges.contains(.all) {
      path.addPath(Path(CGRect(x: rect.minX, y: rect.minY, width: rect.width, height: width)))
    }
    
    if edges.contains(.bottom) || edges.contains(.all) {
      path.addPath(Path(CGRect(x: rect.minX, y: rect.maxY - width, width: rect.width, height: width)))
    }
    
    if edges.contains(.leading) || edges.contains(.all) {
      path.addPath(Path(CGRect(x: rect.minX, y: rect.minY, width: width, height: rect.height)))
    }
    
    if edges.contains(.trailing) || edges.contains(.all) {
      path.addPath(Path(CGRect(x: rect.maxX - width, y: rect.minY, width: width, height: rect.height)))
    }
    
    return path
  }
}
