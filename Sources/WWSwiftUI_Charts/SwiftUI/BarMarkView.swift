//
//  BarMarkView.swift
//  WWSwiftUI_MultiDatePicker
//
//  Created by William.Weng on 2026/1/7.
//

import UIKit
import SwiftUI
import Charts
import WWSwiftUI_MultiDatePicker

// MARK: - ChartsView (SwiftUI)
public extension WWSwiftUI {
    
    struct BarMarkView<T: WWSwiftUI.BarMarkValueProtocol>: View {
        
        @ObservedObject var model: BarMarkViewModel<T>
        
        private let orientation: NSLayoutConstraint.Axis
        private let barColors: [Color]
        
        /// 初始化
        /// - Parameters:
        ///   - model: ChartsViewModel<T>
        ///   - barColors: 柱狀圖的數值顏色
        ///   - orientation: 方向 (水平 / 垂直)
        public init(model: BarMarkViewModel<T>, barColors: [Color] = [.blue], orientation: NSLayoutConstraint.Axis = .vertical) {
            self.model = model
            self.barColors = barColors
            self.orientation = orientation
        }
        
        public var body: some View {
            
            Chart(model.data) { item in
                let index = model.data.firstIndex(where: { $0.id == item.id }) ?? 0
                barMarkMaker(item: item, orientation: orientation)
                .foregroundStyle(barColors[index % barColors.count])
            }
            .background(.clear)
            .padding()
        }
    }
}

// MARK: - 小工具
private extension WWSwiftUI.BarMarkView {
    
    /// 根據方向決定柱狀圖的x,y軸顯示
    /// - Parameters:
    ///   - item: <WWSwiftUI.BarMarkDataProtocol>
    ///   - orientation: 方向 (水平 / 垂直)
    /// - Returns: BarMark
    func barMarkMaker<T: WWSwiftUI.BarMarkValueProtocol>(item: T, orientation: NSLayoutConstraint.Axis) -> BarMark {
        switch orientation {
        case .horizontal: return BarMark(x: .value("Value", item.value), y: .value("Label", item.label))
        case .vertical: return BarMark(x: .value("Label", item.label), y: .value("Value", item.value))
        }
    }
}
