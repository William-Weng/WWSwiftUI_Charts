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
        
        private let fieldKey = (label: "Label", value: "Value")
        private let orientation: NSLayoutConstraint.Axis
        private let unit: Calendar.Component
        private let lineWidth: CGFloat
        private let lineColors: [Color]
        private let useAnnotation: Bool
                
        @ObservedObject var model: LineMarkViewModel<T>
        
        /// [初始化設定](https://ithelp.ithome.com.tw/articles/10291932)
        /// - Parameters:
        ///   - model: LineMarkViewModel<T>
        ///   - lineWidth: 線寬
        ///   - lineColors: 線段顏色
        ///   - useAnnotation: 是否顯示數值文字
        ///   - unit: 時間單位
        ///   - orientation: 顯示方向 (橫 / 直)
        public init(model: LineMarkViewModel<T>, lineWidth: CGFloat = 1, lineColors: [Color] = [], useAnnotation: Bool = false, unit: Calendar.Component = .day, orientation: NSLayoutConstraint.Axis = .vertical) {
            self.model = model
            self.orientation = orientation
            self.unit = unit
            self.lineWidth = lineWidth
            self.lineColors = lineColors
            self.useAnnotation = useAnnotation
        }
        
        public var body: some View {
            
            Chart(model.data, id: \.id) { series in
                
                ForEach(series.data, id: \.id) { item in
                    
                    lineMarkMaker(item: item, orientation: orientation, unit: unit)
                        .lineStyle(StrokeStyle(lineWidth: lineWidth))
                        .foregroundStyle(by: .value("Label", series.label))
                        .symbol(by: .value("Label", series.label))
                    
                    if (useAnnotation) { pointMarkMaker(item: item, orientation: orientation, unit: unit) }
                }
            }
            ._if(!lineColors.isEmpty) {
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
    ///   - unit: 日期單位
    /// - Returns: BarMark
    func lineMarkMaker<T: WWSwiftUI.LineMarkValueProtocol>(item: T, orientation: NSLayoutConstraint.Axis, unit: Calendar.Component) -> LineMark {
        switch orientation {
        case .horizontal: return LineMark(x: .value(fieldKey.value, item.value), y: .value(fieldKey.label, item.date, unit: unit))
        case .vertical: return LineMark(x: .value(fieldKey.label, item.date, unit: unit), y: .value(fieldKey.value, item.value))
        }
    }
    
    /// 產生註記文字
    /// - Parameters:
    ///   - item: <WWSwiftUI.LineMarkValueProtocol>
    ///   - orientation: 方向 (水平 / 垂直)
    ///   - unit: 日期單位
    /// - Returns: some ChartContent
    func pointMarkMaker<T: WWSwiftUI.LineMarkValueProtocol>(item: T, orientation: NSLayoutConstraint.Axis, unit: Calendar.Component) -> some ChartContent {
        
        let pointMark: PointMark
        
        switch orientation {
        case .horizontal: pointMark = PointMark(x: .value(fieldKey.value, item.value), y: .value(fieldKey.label, item.date, unit: unit))
        case .vertical: pointMark = PointMark(x: .value(fieldKey.label, item.date, unit: unit), y: .value(fieldKey.value, item.value))
        }
        
        let content = pointMark
            .annotation(position: .automatic, alignment: .center) {
                Text("\(item.value)")
                .font(.caption2)
            }
        
        return content
    }
}
