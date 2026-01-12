//
//  ChartsView.swift
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
    
    struct ChartsView<T: WWSwiftUI.ChartsDataProtocol>: View {
        
        @ObservedObject var model: ChartsViewModel<T>
        
        private let orientation: NSLayoutConstraint.Axis
        private let barColors: [Color]
        
        /// 初始化
        /// - Parameters:
        ///   - model: ChartsViewModel<T>
        ///   - barColors: 柱狀圖的顏色
        ///   - orientation: 方向 (水平 / 垂直)
        public init(model: ChartsViewModel<T>, barColors: [Color] = [.blue], orientation: NSLayoutConstraint.Axis) {
            self.model = model
            self.barColors = barColors
            self.orientation = orientation
        }
        
        public var body: some View {
            
            Chart(model.datas) { item in
                let index = model.datas.firstIndex(where: { $0.id == item.id }) ?? 0
                barMarkMaker(item: item, orientation: orientation)
                .foregroundStyle(barColors[index % barColors.count])
            }
            .padding()
        }
    }
}

// MARK: - 小工具
private extension WWSwiftUI.ChartsView {
    
    /// 根據方向決定柱狀圖的x,y軸顯示
    /// - Parameters:
    ///   - item: <WWSwiftUI.ChartsDataProtocol>
    ///   - orientation: 方向 (水平 / 垂直)
    /// - Returns: BarMark
    func barMarkMaker<T: WWSwiftUI.ChartsDataProtocol>(item: T, orientation: NSLayoutConstraint.Axis) -> BarMark {
        switch orientation {
        case .horizontal: return BarMark(x: .value("Value", item.value), y: .value("Label", item.label))
        case .vertical: return BarMark(x: .value("Label", item.label), y: .value("Value", item.value))
        }
    }
}
