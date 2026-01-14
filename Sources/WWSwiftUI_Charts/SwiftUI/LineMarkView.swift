//
//  LineMarkView.swift
//  WWSwiftUI_Charts
//
//  Created by iOS on 2026/1/13.
//

import SwiftUI
import Charts
import WWSwiftUI_MultiDatePicker

// MARK: - 折線圖 (SwiftUI)
public extension WWSwiftUI {
    
    struct LineMarkView<T: WWSwiftUI.LineMarkDataProtocol>: View {
        
        private let orientation: NSLayoutConstraint.Axis
        private let unit: Calendar.Component
        private let lineWidth: CGFloat
        private let lineColors: [Color]
                
        @ObservedObject var model: LineMarkViewModel<T>
        
        /// 初始化設定
        /// - Parameters:
        ///   - model: LineMarkViewModel<T>
        ///   - lineWidth: 線寬
        ///   - lineColors: 線段顏色
        ///   - unit: 時間單位
        ///   - orientation: 顯示方向 (橫 / 直)
        public init(model: LineMarkViewModel<T>, lineWidth: CGFloat = 1, lineColors: [Color] = [], unit: Calendar.Component = .day, orientation: NSLayoutConstraint.Axis = .vertical) {
            self.model = model
            self.orientation = orientation
            self.unit = unit
            self.lineWidth = lineWidth
            self.lineColors = lineColors
        }
        
        public var body: some View {
                        
            Chart(model.data, id: \.id) { series in
                                
                ForEach(series.data) { item in
                    
                    let index = model.data.firstIndex(where: { $0.id == item.id }) ?? 0
                    
                    lineMarkMaker(item: item, orientation: orientation, unit: unit)
                        .lineStyle(StrokeStyle(lineWidth: lineWidth))
                        .foregroundStyle(by: .value("Label", series.label))
                        .symbol(by: .value("Label", series.label))
                }
            }
            .if(!lineColors.isEmpty) {
                $0.chartForegroundStyleScale(range: lineColors)
                  .chartLegend(.visible)
            }
            .background(.clear)
            .padding()
        }
    }
}

// MARK: - 小工具
private extension WWSwiftUI.LineMarkView {
    
    /// 根據方向決定柱狀圖的x,y軸顯示
    /// - Parameters:
    ///   - item: <WWSwiftUI.LineMarkValueProtocol>
    ///   - orientation: 方向 (水平 / 垂直)
    /// - Returns: BarMark
    func lineMarkMaker<T: WWSwiftUI.LineMarkValueProtocol>(item: T, orientation: NSLayoutConstraint.Axis, unit: Calendar.Component) -> LineMark {
        switch orientation {
        case .horizontal: return LineMark(x: .value("Value", item.value), y: .value("Label", item.date, unit: unit))
        case .vertical: return LineMark(x: .value("Label", item.date, unit: unit), y: .value("Value", item.value))
        }
    }
}
