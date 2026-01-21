//
//  Utility.swift
//  WWSwiftUI_Charts
//
//  Created by iOS on 2026/1/21.
//

import Foundation
import SwiftUI
import Charts

// MARK: - 共用工具
final class Utility {
    static let shared = Utility()
}

// MARK: - 小工具
extension Utility {
    
    /// 修正軸上圖表尺規的最大值 (防止尺規產生動畫)
    /// - Parameters:
    ///   - chart: some View
    ///   - orientation: 方向
    /// - Returns: some View
    func fixScale<Value: Plottable>(chart: some View, value: Value?, orientation: NSLayoutConstraint.Axis) -> some View {
        
        var intValue: Int = 0
        
        if let value = value as? Int { intValue = value._adjustedNumber()}
        if let value = value as? Float { intValue = Int(value)._adjustedNumber() }
        if let value = value as? Double { intValue = Int(value)._adjustedNumber() }
        
        return Group {
            
            switch orientation {
            case .horizontal:
                chart
                    .chartYAxis { AxisMarks(values: .automatic) }
                    .chartXScale(domain: 0...intValue)
            case .vertical:
                chart
                    .chartXAxis { AxisMarks(values: .automatic) }
                    .chartYScale(domain: 0...intValue)
            }
        }
    }
}
