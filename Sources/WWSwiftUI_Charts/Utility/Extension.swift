//
//  Extension.swift
//  WWSwiftUI_Charts
//
//  Created by William.Weng on 2026/1/15.
//

import SwiftUI
import Charts

// MARK: - Int
extension Int {
    
    /// 計算出數字位數
    /// - Returns: Int
    func _digitsCount() -> Int {
        
        guard self != 0 else { return 1 }
        
        let absNumber = abs(Double(self))
        return Int(log10(absNumber).rounded(.down)) + 1
    }
    
    /// 找出最圖表適合的數字 (加上安全的範圍) => 100 ~ 999 => 999 + 100 / 1000 ~ 9999 => 9999 + 1000
    /// - Returns: Int
    func _adjustedNumber() -> Int {
        
        guard self != 0 else { return self }
        
        let digits = _digitsCount()
        let add = Int(pow(10.0, Double(digits - 1)))
        return self + add
    }
}

// MARK: - ChartContent
extension ChartContent {
    
    /// 圖表註解
    /// - Parameters:
    ///   - value: 數值
    ///   - font: 字型
    ///   - foregroundStyle: 文字類型
    /// - Returns: ChartContent
    func _annotation<S: ShapeStyle>(value: Any, font: Font?, style: S) -> some ChartContent {
        
        annotation(position: .automatic) {
            Text("\(value)")
                .font(font)
                .foregroundStyle(style)
        }
    }
}

// MARK: - Plottable
extension Plottable {
    
    /// 決定進度動畫時的數值 (Int / Float / Double)
    /// - Parameters:
    ///   - progress: 進度
    /// - Returns: Double
    func _animatedValue(progress: Double) -> Double {
        
        let animatedValue: Double
        
        switch self {
        case let intValue as Int: animatedValue = Double(intValue) * progress
        case let floatValue as Float: animatedValue = Double(floatValue) * progress
        case let doubleValue as Double: animatedValue = doubleValue * progress
        default: animatedValue = 0
        }
        
        return animatedValue
    }
}
