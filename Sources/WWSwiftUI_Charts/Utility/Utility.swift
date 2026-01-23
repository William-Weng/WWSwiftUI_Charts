//
//  Utility.swift
//  WWSwiftUI_Charts
//
//  Created by iOS on 2026/1/21.
//

import Foundation
import SwiftUI
import Charts
import WWSwiftUI_MultiDatePicker
import WWSwiftUI_Charts

// MARK: - 共用工具
final class Utility {
    static let shared = Utility()
}

// MARK: - 小工具
extension Utility {
    
    /// 設定軸上圖表尺規的最大值 (防止尺規產生動畫)
    /// - Parameters:
    ///   - chart: some View
    ///   - intValue: 設定值
    ///   - orientation: 方向
    /// - Returns: some View
    func setChartScale(chart: some View, intValue: Int, orientation: NSLayoutConstraint.Axis) -> some View {
        
        return Group {
            switch orientation {
            case .horizontal:
                chart.chartYAxis { AxisMarks(values: .automatic) }
                     .chartXScale(domain: 0...intValue)
            case .vertical:
                chart.chartXAxis { AxisMarks(values: .automatic) }
                     .chartYScale(domain: 0...intValue)
            }
        }
    }
    
    /// 修正軸上圖表尺規的最大值 (防止尺規產生動畫)
    /// - Parameters:
    ///   - chart: some View
    ///   - orientation: 方向
    /// - Returns: some View
    func fixChartScale<Value: Plottable>(chart: some View, value: Value?, orientation: NSLayoutConstraint.Axis) -> some View {
        
        var intValue: Int = 0
        
        if let value = value as? Int { intValue = value._adjustedNumber()}
        if let value = value as? Float { intValue = Int(value)._adjustedNumber() }
        if let value = value as? Double { intValue = Int(value)._adjustedNumber() }
        
        return Group {
            
            switch orientation {
            case .horizontal:
                chart.chartYAxis { AxisMarks(values: .automatic) }
                     .chartXScale(domain: 0...intValue)
            case .vertical:
                chart.chartXAxis { AxisMarks(values: .automatic) }
                     .chartYScale(domain: 0...intValue)
            }
        }
    }
    
    /// 修正軸上圖表尺規的最大值 (防止尺規產生動畫)
    /// - Parameters:
    ///   - chart: some View
    ///   - item: T?
    ///   - pointScale: WWSwiftUI.PointScale
    /// - Returns: some View
    func fixChartScale<T: WWSwiftUI.PointMarkValueProtocol>(chart: some View, item: T?, pointScale: WWSwiftUI.PointScale) -> some View {
        
        var intValueX: Int = 0
        var intValueY: Int = 0
        
        if let value = item?.xValue as? (Int) { intValueX = value._adjustedNumber()}
        if let value = item?.xValue as? Float { intValueX = Int(value)._adjustedNumber() }
        if let value = item?.xValue as? Double { intValueX = Int(value)._adjustedNumber() }
        
        if let value = item?.yValue as? Int { intValueY = value._adjustedNumber()}
        if let value = item?.yValue as? Float { intValueY = Int(value)._adjustedNumber() }
        if let value = item?.yValue as? Double { intValueY = Int(value)._adjustedNumber() }
        
        return Group {
            chart.chartXScale(domain: 0...(pointScale.x ?? intValueX))
                 .chartYScale(domain: 0...(pointScale.y ?? intValueY))
        }
    }
    
    /// 繪出輔助線
    /// - Parameters:
    ///   - guideLine: WWSwiftUI.ChartGuideLine
    ///   - key: String
    ///   - orientation: 方向 (水平 / 垂直)
    /// - Returns: ChartContent
    func guideLineMaker(_ guideLine: WWSwiftUI.ChartGuideLine, key: String = "Guide", orientation: NSLayoutConstraint.Axis) -> some ChartContent {
        
        switch orientation {
        case .horizontal:
            RuleMark(x: .value(key, guideLine.value))
                .foregroundStyle(guideLine.color)
                .lineStyle(guideLine.style)
        case .vertical:
            RuleMark(y: .value(key, guideLine.value))
                .foregroundStyle(guideLine.color)
                .lineStyle(guideLine.style)
        }
    }
}
