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
    
    struct BarScaleModifier<T: WWSwiftUI.BarMarkValueProtocol>: ViewModifier {
        
        let maxData: T?
        let orientation: NSLayoutConstraint.Axis
        let maxScale: Int?
        
        func body(content: Content) -> some View {
            
            if let maxScale = maxScale {
                Utility.shared.setChartScale(chart: content, intValue: maxScale, orientation: orientation)
            } else {
                Utility.shared.fixChartScale(chart: content, value: maxData?.value, orientation: orientation)
            }
        }
    }
}

// MARK: - 圖表尺規調整 (整合SwiftUI設定用)
extension WWSwiftUI {
    
    struct LineScaleModifier<T: WWSwiftUI.LineMarkValueProtocol>: ViewModifier {
        
        let maxData: T?
        let orientation: NSLayoutConstraint.Axis
        let maxScale: Int?
        
        func body(content: Content) -> some View {
            
            if let maxScale = maxScale {
                Utility.shared.setChartScale(chart: content, intValue: maxScale, orientation: orientation)
            } else {
                Utility.shared.fixChartScale(chart: content, value: maxData?.value, orientation: orientation)
            }
        }
    }
}

// MARK: - 圖表尺規調整 (整合SwiftUI設定用)
extension WWSwiftUI {
    
    struct PointScaleModifier<T: WWSwiftUI.PointMarkValueProtocol>: ViewModifier {
        
        let maxData: T?
        let maxPointScale: PointScale
        
        func body(content: Content) -> some View {
            Utility.shared.fixChartScale(chart: content, item: maxData, pointScale: maxPointScale)
        }
    }
}
