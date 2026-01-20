//
//  BarMarkView.swift
//  WWSwiftUI_MultiDatePicker
//
//  Created by William.Weng on 2026/1/7.
//

import SwiftUI
import Charts
import WWSwiftUI_MultiDatePicker

// MARK: - 柱狀圖 (SwiftUI)
public extension WWSwiftUI {
    
    struct BarMarkView<T: BarMarkValueProtocol>: View {
        
        @ObservedObject var model: BarMarkViewModel<T>
        @ObservedObject var viewDelegateModel: BarMarkViewDelegateModel
        
        private let fieldKey = (label: "Label", value: "Value")
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
            self.init(model: model, viewDelegateModel: .init(), barWidth: barWidth, barColors: barColors, useAnnotation: useAnnotation, orientation: orientation)
        }
        
        /// [初始化設定](https://juejin.cn/post/7526331721290137651)
        /// - Parameters:
        ///   - model: ChartsViewModel<T>
        ///   - viewDelegateModel: BarMarkViewDelegateModel
        ///   - barWidth: 柱體寬度
        ///   - barColors: 柱狀圖的數值顏色
        ///   - useAnnotation: 是否顯示數值文字
        ///   - orientation: 方向 (水平 / 垂直)
        init(model: BarMarkViewModel<T>, viewDelegateModel: BarMarkViewDelegateModel, barWidth: MarkDimension, barColors: [Color], useAnnotation: Bool, orientation: NSLayoutConstraint.Axis) {
            self.model = model
            self.barWidth = barWidth
            self.barColors = barColors
            self.useAnnotation = useAnnotation
            self.orientation = orientation
            self.viewDelegateModel = viewDelegateModel
        }
        
        public var body: some View {
            
            Chart(model.data) { item in
                
                let index = model.data.firstIndex(where: { $0.id == item.id }) ?? 0
                
                barMarkMaker(item: item, progress: viewDelegateModel.progress, orientation: orientation)
                    ._if(!barColors.isEmpty) { $0.foregroundStyle(barColors[index % barColors.count]) }
                    ._if(useAnnotation) { $0._annotation(value: item.value, font: .caption2, foregroundStyle : .primary) }
            }
            ._if(viewDelegateModel.delegate != nil) {
                $0._chartOverlayOnTap { viewDelegateModel.delegate?.barMarkView(self, proxy: $0, didSelected: $1) }
                  .modifier(ScaleModifier(item: model.maxData(), orientation: orientation))
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
    ///   - progress: 進度動畫 (0% ~ 100%)
    ///   - orientation: 方向 (水平 / 垂直)
    /// - Returns: BarMark
    func barMarkMaker<T: WWSwiftUI.BarMarkValueProtocol>(item: T, progress: Double, orientation: NSLayoutConstraint.Axis) -> BarMark {
        
        let value = animatedValue(item: item, progress: progress)
        
        switch orientation {
        case .horizontal: return BarMark(x: .value(fieldKey.value, value), y: .value(fieldKey.label, item.label), width: barWidth)
        case .vertical: return BarMark(x: .value(fieldKey.label, item.label), y: .value(fieldKey.value, value), width: barWidth)
        }
    }
    
    /// 決定動畫時的數值
    /// - Parameters:
    ///   - item: T: WWSwiftUI.BarMarkValueProtocol
    ///   - progress: Double
    /// - Returns: Double
    func animatedValue<T: WWSwiftUI.BarMarkValueProtocol>(item: T, progress: Double) -> Double {
        
        let animatedValue: Double
        
        switch item.value {
        case let intValue as Int: animatedValue = Double(intValue) * progress
        case let floatValue as Float: animatedValue = floatValue * progress
        case let doubleValue as Double: animatedValue = doubleValue * progress
        default: animatedValue = 0
        }
        
        return animatedValue
    }
}
