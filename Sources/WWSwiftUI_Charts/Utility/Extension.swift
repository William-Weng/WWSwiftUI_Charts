//
//  Extension.swift
//  WWSwiftUI_Charts
//
//  Created by William.Weng on 2026/1/15.
//

import SwiftUI
import Charts

// MARK: - View
extension View {
    
    /// 點擊圖表的反應
    /// - Parameter action: (ChartProxy, CGPoint) -> Void
    /// - Returns: View
    func _chartOverlayOnTap(action: @escaping (ChartProxy, CGPoint) -> Void) -> some View {
        
        chartOverlay { proxy in
            GeometryReader { geometry in
                Rectangle()
                    .fill(.clear)
                    .contentShape(Rectangle())
                    .onTapGesture { location in action(proxy, location) }
            }
        }
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
    func _annotation(value: Any, font: Font?, foregroundStyle: HierarchicalShapeStyle) -> some ChartContent {
        
        annotation(position: .automatic) {
            Text("\(value)")
                .font(font)
                .foregroundStyle(foregroundStyle)
        }
    }
}
