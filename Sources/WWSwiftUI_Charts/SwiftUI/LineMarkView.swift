//
//  LineMarkView.swift
//  WWSwiftUI_Charts
//
//  Created by William.Weng on 2026/1/13.
//

import SwiftUI
import Charts
import WWSwiftUI_MultiDatePicker

// MARK: - 折線圖 (SwiftUI)
public extension WWSwiftUI {
    
    struct LineMarkView<T: LineMarkDataProtocol>: View {
        
        @ObservedObject var model: LineMarkViewModel<T>
        @ObservedObject var viewDelegateModel: LineMarkViewDelegateModel
        
        private let fieldKey = (label: "Label", value: "Value")
        private let orientation: NSLayoutConstraint.Axis
        private let unit: Calendar.Component
        private let lineWidth: CGFloat
        private let lineColors: [Color]
        private let useAnnotation: Bool
        
        /// [初始化設定](https://ithelp.ithome.com.tw/articles/10291932)
        /// - Parameters:
        ///   - model: LineMarkViewModel<T>
        ///   - lineWidth: 線寬
        ///   - lineColors: 線段顏色
        ///   - useAnnotation: 是否顯示數值文字
        ///   - unit: 時間單位
        ///   - orientation: 顯示方向 (橫 / 直)
        public init(model: LineMarkViewModel<T>, lineWidth: CGFloat = 1, lineColors: [Color] = [], useAnnotation: Bool = false, unit: Calendar.Component = .day, orientation: NSLayoutConstraint.Axis = .vertical) {
            self.init(model: model, viewDelegateModel: .init(), lineWidth: lineWidth, lineColors: lineColors, useAnnotation: useAnnotation, unit: unit, orientation: orientation)
        }
        
        /// [初始化設定](https://ithelp.ithome.com.tw/articles/10291932)
        /// - Parameters:
        ///   - model: LineMarkViewModel<T>
        ///   - viewDelegateModel: 線寬
        ///   - lineWidth: 線寬
        ///   - lineColors: 線段顏色
        ///   - useAnnotation: 是否顯示數值文字
        ///   - unit: 時間單位
        ///   - orientation: 顯示方向 (橫 / 直)
        init(model: LineMarkViewModel<T>, viewDelegateModel: LineMarkViewDelegateModel, lineWidth: CGFloat, lineColors: [Color], useAnnotation: Bool, unit: Calendar.Component, orientation: NSLayoutConstraint.Axis) {
            self.model = model
            self.orientation = orientation
            self.unit = unit
            self.lineWidth = lineWidth
            self.lineColors = lineColors
            self.useAnnotation = useAnnotation
            self.viewDelegateModel = viewDelegateModel
        }
        
        public var body: some View {
            
            Chart(model.data, id: \.id) { series in
                
                ForEach(series.data, id: \.id) { item in
                    
                    lineMarkMaker(item: item, progress: viewDelegateModel.progress, orientation: orientation, unit: unit)
                        .lineStyle(StrokeStyle(lineWidth: lineWidth))
                        .foregroundStyle(by: .value(fieldKey.label, series.label))
                        .symbol(by: .value(fieldKey.label, series.label))
                        .interpolationMethod(viewDelegateModel.interpolationMethod)
                    
                    if (useAnnotation) {
                        pointMarkMaker(item: item, progress: viewDelegateModel.progress, orientation: orientation, unit: unit)
                            .foregroundStyle(by: .value(fieldKey.label, series.label))
                    }
                    
                    if let guideLine = viewDelegateModel.guideLine { Utility.shared.guideLineMaker(guideLine, orientation: orientation) }
                }
            }._if(!lineColors.isEmpty) {
                $0.chartForegroundStyleScale(range: lineColors)
                  .chartLegend(.visible)
            }._if(viewDelegateModel.delegate != nil) {
                $0._chartOverlayOnTap { viewDelegateModel.delegate?.lineMarkView(self, proxy: $0, didSelected: $1) }
                  .modifier(LineScaleModifier(maxData: model.maxData(), orientation: orientation, maxScale: viewDelegateModel.maxScale))
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
    ///   - progress: 進度動畫 (0% ~ 100%)
    ///   - orientation: 方向 (水平 / 垂直)
    ///   - unit: 日期單位
    /// - Returns: BarMark
    func lineMarkMaker<T: WWSwiftUI.LineMarkValueProtocol>(item: T, progress: Double, orientation: NSLayoutConstraint.Axis, unit: Calendar.Component) -> LineMark {
        
        let value = item.value._animatedValue(progress: progress)
        
        switch orientation {
        case .horizontal: return LineMark(x: .value(fieldKey.value, value), y: .value(fieldKey.label, item.date, unit: unit))
        case .vertical: return LineMark(x: .value(fieldKey.label, item.date, unit: unit), y: .value(fieldKey.value, value))
        }
    }
    
    /// 產生註記文字
    /// - Parameters:
    ///   - item: <WWSwiftUI.LineMarkValueProtocol>
    ///   - progress: 進度動畫 (0% ~ 100%)
    ///   - orientation: 方向 (水平 / 垂直)
    ///   - unit: 日期單位
    /// - Returns: some ChartContent
    func pointMarkMaker<T: WWSwiftUI.LineMarkValueProtocol>(item: T, progress: Double, orientation: NSLayoutConstraint.Axis, unit: Calendar.Component) -> some ChartContent {
        
        let pointMark: PointMark
        let value = item.value._animatedValue(progress: progress)
        
        switch orientation {
        case .horizontal: pointMark = PointMark(x: .value(fieldKey.value, value), y: .value(fieldKey.label, item.date, unit: unit))
        case .vertical: pointMark = PointMark(x: .value(fieldKey.label, item.date, unit: unit), y: .value(fieldKey.value, value))
        }
        
        let content = pointMark._annotation(value: item.value, font: .caption2, style: .primary)
        return content
    }
}
