//
//  Constant.swift
//  WWSwiftUI_Charts
//
//  Created by William.Weng on 2026/1/21.
//

import Foundation
import WWSwiftUI_MultiDatePicker
import SwiftUICore

// MARK: - WWSwiftUI
public extension WWSwiftUI {
    
    /// x, y軸數值
    struct PointScale {
        
        let x: Int?
        let y: Int?
        
        public init(x: Int?, y: Int?) {
            self.x = x
            self.y = y
        }
    }
}

// MARK: - WWSwiftUI
public extension WWSwiftUI {
    
    typealias ChartGuideLine = (value: Double, color: Color, style: StrokeStyle)    // (數值, 顏色, 樣式)
}

// MARK: - WWSwiftUI
public extension WWSwiftUI {
    
    /// 散點圖的數據顯示模式
    enum PointMarkDisplayMode {
        case x      // 23
        case y      // 64
        case full   // (23, 64)
    }
}
