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
    
    struct BarMarkView<T: WWSwiftUI.BarMarkValueProtocol>: View {
        
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
        
        /// 初始化設定
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
            ._if(viewDelegateModel.delegate != nil) { chart in
                chart._chartOverlayOnTap { viewDelegateModel.delegate?.barMarkView(self, proxy: $0, didSelected: $1) }
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
        case .horizontal: return BarMark(x: .value(fieldKey.value, item.value), y: .value(fieldKey.label, item.label), width: barWidth)
        case .vertical: return BarMark(x: .value(fieldKey.label, item.label), y: .value(fieldKey.value, item.value), width: barWidth)
        }
    }
}
