//
//  Charts.swift
//  WWSwiftUI_MultiDatePicker
//
//  Created by William.Weng on 2026/1/7.
//

import UIKit
import SwiftUI
import WWSwiftUI_MultiDatePicker

// MARK: - BarMark
public extension WWSwiftUI {
    
    class BarMark<T: BarMarkValueProtocol>: AnyObject {
        
        public var view: UIView { hostingController.view }
        
        private let hostingController: UIHostingController<AnyView>
        
        /// 初始化
        /// - Parameters:
        ///   - model: BarMarkViewModel<T>
        ///   - barColors: 柱狀圖的顏色
        ///   - orientation: 方向 (水平 / 垂直)
        public init<T>(model: BarMarkViewModel<T>, barColors: [Color] = [.blue], orientation: NSLayoutConstraint.Axis = .vertical) {
            let chartsView = WWSwiftUI.BarMarkView(model: model, barColors: barColors, orientation: orientation)
            hostingController = UIHostingController(rootView: AnyView(chartsView))
        }
        
        deinit {
            hostingController.willMove(toParent: .none)
            hostingController.view.removeFromSuperview()
            hostingController.removeFromParent()
        }
    }
}

// MARK: - 公開函式
public extension WWSwiftUI.BarMark {
    
    /// [移動到UIViewController上](https://www.keaura.com/blog/a-multi-date-picker-for-swiftui)
    /// - Parameters:
    ///   - parent: UIViewController
    ///   - otherView: UIView?
    func move(toParent parent: UIViewController, on otherView: UIView? = .none) {
        
        parent.addChild(hostingController)
        hostingController.didMove(toParent: parent)
        
        if let otherView = otherView { hostingController.view._autolayout(on: otherView) }
    }
}
