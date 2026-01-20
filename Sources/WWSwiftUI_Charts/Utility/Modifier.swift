//
//  Modifier.swift
//  WWSwiftUI_Charts
//
//  Created by William.Weng on 2026/1/20.
//

import SwiftUI
import Charts
import WWSwiftUI_MultiDatePicker

// MARK: - 圖表尺規調整 (整合SwiftUI設定用)
extension WWSwiftUI {
    
    struct ScaleModifier<T: WWSwiftUI.BarMarkValueProtocol>: ViewModifier {
        
        let item: T?
        let orientation: NSLayoutConstraint.Axis
        
        func body(content: Content) -> some View {
            fixScale(chart: content, orientation: orientation)
        }
    }
}

// MARK: - 小工具
private extension WWSwiftUI.ScaleModifier {
    
    /// 修正軸上圖表尺規的最大值 (防止尺規產生動畫)
    /// - Parameters:
    ///   - chart: some View
    ///   - minValue: 尺規最小值
    ///   - orientation: 方向
    /// - Returns: some View
    func fixScale(chart: some View, minValue: Int = 1000, orientation: NSLayoutConstraint.Axis) -> some View {
        
        var maxScale = 100
        
        if let value = item?.value as? Int { maxScale = value + minValue }
        if let value = item?.value as? Double { maxScale = Int(value) + minValue }
        
        return Group {
            
            switch orientation {
                case .horizontal:
                chart
                    .chartYAxis { AxisMarks(values: .automatic) }
                    .chartXScale(domain: 0...maxScale)
            case .vertical:
                chart
                    .chartXAxis { AxisMarks(values: .automatic) }
                    .chartYScale(domain: 0...maxScale)
            }
        }
    }
}
