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

// MARK: - 柱狀圖 (SwiftUI)
public extension WWSwiftUI {
    
    struct BarMarkView<T: WWSwiftUI.BarMarkValueProtocol>: View {
        
        @ObservedObject var model: BarMarkViewModel<T>
        
        private let orientation: NSLayoutConstraint.Axis
        private let barWidth: MarkDimension
        private let barColors: [Color]
        private let useAnnotation: Bool
        
        /// [初始化設定](https://www.youtube.com/watch?v=uloAs9tQIcA)
        /// - Parameters:
        ///   - model: ChartsViewModel<T>
        ///   - barWidth: 柱體寬度
        ///   - barColors: 柱狀圖的數值顏色
        ///   - useAnnotation: 是否顯示數值文字
        ///   - orientation: 方向 (水平 / 垂直)
        public init(model: BarMarkViewModel<T>, barWidth: MarkDimension = .automatic, barColors: [Color] = [.blue], useAnnotation: Bool = false, orientation: NSLayoutConstraint.Axis = .vertical) {
            self.model = model
            self.barWidth = barWidth
            self.barColors = barColors
            self.orientation = orientation
            self.useAnnotation = useAnnotation
        }
        
        public var body: some View {
            
            Chart(model.data) { item in
                
                let index = model.data.firstIndex(where: { $0.id == item.id }) ?? 0
                barMarkMaker(item: item, orientation: orientation)
                    .foregroundStyle(barColors[index % barColors.count])
                    ._if(useAnnotation) {
                        $0.annotation(position: .automatic) {
                            Text("\(item.value)")
                                .font(.caption2)
                                .foregroundStyle(.primary)
                        }
                    }
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
        case .horizontal: return BarMark(x: .value("Value", item.value), y: .value("Label", item.label), width: barWidth)
        case .vertical: return BarMark(x: .value("Label", item.label), y: .value("Value", item.value), width: barWidth)
        }
    }
}
