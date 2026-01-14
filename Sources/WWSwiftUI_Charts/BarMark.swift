//
//  Charts.swift
//  WWSwiftUI_MultiDatePicker
//
//  Created by William.Weng on 2026/1/7.
//

import UIKit
import SwiftUI
import Charts
import WWSwiftUI_MultiDatePicker

// MARK: - 柱狀圖
public extension WWSwiftUI {
    
    class BarMark<T: BarMarkValueProtocol>: WWSwiftUI.`Protocol` {
                
        public let hostingController: UIHostingController<AnyView>
        
        public var view: UIView { hostingController.view }
        
        /// 初始化設定
        /// - Parameters:
        ///   - model: BarMarkViewModel<T>
        ///   - barWidth: 柱體寬度
        ///   - barColors: 柱狀圖的顏色
        ///   - useAnnotation: 是否顯示數值文字
        ///   - orientation: 方向 (水平 / 垂直)
        public init<T>(model: BarMarkViewModel<T>, barWidth: MarkDimension = .automatic, barColors: [Color] = [.blue], useAnnotation: Bool = false, orientation: NSLayoutConstraint.Axis = .vertical) {
            let rootView = WWSwiftUI.BarMarkView(model: model, barWidth: barWidth, barColors: barColors, useAnnotation: useAnnotation, orientation: orientation)
            hostingController = UIHostingController(rootView: AnyView(rootView))
        }
        
        deinit {
            hostingController.willMove(toParent: .none)
            hostingController.view.removeFromSuperview()
            hostingController.removeFromParent()
        }
    }
}
