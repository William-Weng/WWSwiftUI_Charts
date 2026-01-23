//
//  PointMarkView.swift
//  WWSwiftUI_Charts
//
//  Created by William.Weng on 2026/1/15.
//

import SwiftUI
import Charts
import WWSwiftUI_MultiDatePicker

// MARK: - 散點圖 (SwiftUI)
public extension WWSwiftUI {
    
    struct PointMarkView<T: PointMarkValueProtocol>: View {
        
        @ObservedObject var model: PointMarkViewModel<T>
        @ObservedObject var viewDelegateModel: PointMarkViewDelegateModel
        
        private let fieldKey = (label: "Label", xAxis: "X-axis", yAxis: "Y-axis")
        private let symbolSize: CGFloat
        private let useAnnotation: Bool
        private let pointColors: [Color]
        
        /// [初始化設定](https://www.swiftyplace.com/blog/swiftcharts-create-charts-and-graphs-in-swiftui)
        /// - Parameters:
        ///   - model: PointMarkViewModel<T>
        ///   - symbolSize: 散點的大小
        ///   - pointColors: 散點的顏色
        ///   - useAnnotation: 是否顯示數值文字
        public init(model: PointMarkViewModel<T>, symbolSize: CGFloat = 100, pointColors: [Color] = [], useAnnotation: Bool = false) {
            self.init(model: model, viewDelegateModel: .init(), symbolSize: symbolSize, pointColors: pointColors, useAnnotation: useAnnotation)
        }
        
        /// 初始化設定
        /// - Parameters:
        ///   - model: PointMarkViewModel<T>
        ///   - viewDelegateModel: PointMarkViewDelegateModel
        ///   - symbolSize: 散點的大小
        ///   - pointColors: 散點的顏色
        ///   - useAnnotation: 是否顯示數值文字
        init(model: PointMarkViewModel<T>, viewDelegateModel: PointMarkViewDelegateModel, symbolSize: CGFloat, pointColors: [Color], useAnnotation: Bool) {
            self.model = model
            self.symbolSize = symbolSize
            self.useAnnotation = useAnnotation
            self.viewDelegateModel = viewDelegateModel
            self.pointColors = pointColors
        }
        
        public var body: some View {
            
            Chart(model.data) { point in
                pointMarkMaker(point: point, progress: viewDelegateModel.progress)
                    .symbol(by: .value(fieldKey.label, point.label))
                    .symbolSize(symbolSize)
                    .foregroundStyle(by: .value(fieldKey.label, point.label))
                    ._if(useAnnotation) { $0._annotation(value: formatValue(point, mode: viewDelegateModel.displayMode), font: .caption2, foregroundStyle: .primary) }
                
                if let guideLine = viewDelegateModel.guideLine { Utility.shared.guideLineMaker(guideLine, orientation: viewDelegateModel.orientation) }
                
            }._if(viewDelegateModel.delegate != nil) {
                $0._chartOverlayOnTap { viewDelegateModel.delegate?.pointMarkView(self, proxy: $0, didSelected: $1) }
                    .modifier(PointScaleModifier(maxData: model.maxData()))
            }._if(!pointColors.isEmpty) {
                $0.chartForegroundStyleScale(range: pointColors)
                  .chartLegend(.visible)
            }
            .background(.clear)
            .padding()
        }
    }
}

// MARK: - 小工具
private extension WWSwiftUI.PointMarkView {
    
    /// 根據方向決定柱狀圖的x,y軸顯示
    /// - Parameters:
    ///   - item: <WWSwiftUI.BarMarkDataProtocol>
    ///   - progress: 進度動畫 (0% ~ 100%)
    /// - Returns: BarMark
    func pointMarkMaker<T: WWSwiftUI.PointMarkValueProtocol>(point: T, progress: Double) -> PointMark {
        
        let xValue = point.xValue._animatedValue(progress: progress)
        let yValue = point.yValue._animatedValue(progress: progress)
        
        return PointMark(x: .value(fieldKey.xAxis, xValue), y: .value(fieldKey.yAxis, yValue))
    }
    
    /// 處理數值顯示的格式
    /// - Parameters:
    ///   - value: T
    ///   - mode: WWSwiftUI.PointMarkDisplayMode
    /// - Returns: String
    func formatValue(_ value: T, mode: WWSwiftUI.PointMarkDisplayMode) -> String {
        
        switch mode {
        case .x: return "\(value.xValue)"
        case .y: return "\(value.yValue)"
        case .full: return "(\(value.xValue), \(value.yValue))"
        }
    }
}
