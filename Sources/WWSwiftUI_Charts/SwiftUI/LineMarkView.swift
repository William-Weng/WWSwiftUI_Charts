//
//  LineMarkView.swift
//  WWSwiftUI_Charts
//
//  Created by iOS on 2026/1/13.
//

import SwiftUI
import Charts
import WWSwiftUI_MultiDatePicker

// MARK: - ChartsView (SwiftUI)
public extension WWSwiftUI {
    
    struct LineMarkView<T: WWSwiftUI.LineMarkDataProtocol>: View {
        
        private let orientation: NSLayoutConstraint.Axis
        private let unit: Calendar.Component
        
        @ObservedObject var model: LineMarkViewModel<T>
        
        public init(model: LineMarkViewModel<T>, unit: Calendar.Component = .day, orientation: NSLayoutConstraint.Axis = .vertical) {
            self.model = model
            self.orientation = orientation
            self.unit = unit
        }
        
        public var body: some View {
            Chart(model.data, id: \.label) { series in
                ForEach(series.data) { item in
                    lineMarkMaker(item: item, orientation: orientation, unit: unit)
                    .foregroundStyle(by: .value("標題", series.label))
                    .symbol(by: .value("標題", series.label))
                }
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
