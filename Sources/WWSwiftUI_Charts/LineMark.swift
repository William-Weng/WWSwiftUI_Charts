//
//  Charts.swift
//  WWSwiftUI_MultiDatePicker
//
//  Created by William.Weng on 2026/1/7.
//

import UIKit
import SwiftUI
import WWSwiftUI_MultiDatePicker

// MARK: - 折線圖
public extension WWSwiftUI {
    
    class LineMark<T: LineMarkDataProtocol>: WWSwiftUI.`Protocol` {
        
        public let hostingController: UIHostingController<AnyView>
        
        public var view: UIView { hostingController.view }
        
        /// 初始化
        /// - Parameters:
        ///   - model: LineMarkViewModel<T>
        ///   - lineWidth: 線寬
        ///   - lineColors: 線段顏色
        ///   - unit: 日期單位
        ///   - orientation: 方向 (水平 / 垂直)
        public init<T>(model: LineMarkViewModel<T>, lineWidth: CGFloat = 1, lineColors: [Color] = [], unit: Calendar.Component = .day, orientation: NSLayoutConstraint.Axis = .vertical) {
            let rootView = WWSwiftUI.LineMarkView(model: model, lineWidth: lineWidth, lineColors: lineColors, unit: unit, orientation: orientation)
            hostingController = UIHostingController(rootView: AnyView(rootView))
        }
        
        deinit {
            hostingController.willMove(toParent: .none)
            hostingController.view.removeFromSuperview()
            hostingController.removeFromParent()
        }
    }
}

