//
//  LineMark.swift
//  WWSwiftUI_MultiDatePicker
//
//  Created by William.Weng on 2026/1/7.
//

import UIKit
import SwiftUI
import Charts
import WWSwiftUI_MultiDatePicker

// MARK: - 折線圖
public extension WWSwiftUI {
    
    class LineMark<T: LineMarkDataProtocol>: WWSwiftUI.`Protocol` {
        
        public let hostingController: UIHostingController<AnyView>
        
        public var view: UIView { hostingController.view }
        public weak var delegate: WWSwiftUI.LineMarkDelegate?
        
        private var viewDelegateModel = LineMarkViewDelegateModel()
        
        /// [初始化設定](https://developer.apple.com/videos/play/wwdc2022/10137/)
        /// - Parameters:
        ///   - lineWidth: 線寬
        ///   - lineColors: 線段顏色
        ///   - useAnnotation: 是否顯示數值文字
        ///   - unit: 日期單位
        ///   - orientation: 方向 (水平 / 垂直)
        public init<T>(model: LineMarkViewModel<T>, lineWidth: CGFloat = 1, lineColors: [Color] = [], useAnnotation: Bool = false, unit: Calendar.Component = .day, orientation: NSLayoutConstraint.Axis = .vertical) {
            
            let rootView = WWSwiftUI.LineMarkView(model: model, viewDelegateModel: viewDelegateModel, lineWidth: lineWidth, lineColors: lineColors, useAnnotation: useAnnotation, unit: unit, orientation: orientation)
            
            hostingController = UIHostingController(rootView: AnyView(rootView))
            viewDelegateModel.setDelegate(self)
        }
        
        deinit {
            delegate = nil
            viewDelegateModel.delegate = nil
            hostingController.willMove(toParent: .none)
            hostingController.view.removeFromSuperview()
            hostingController.removeFromParent()
        }
    }
}

// MARK: - 開放函式
public extension WWSwiftUI.LineMark {
    
    /// 產生更新動畫
    /// - Parameter animation: 動畫類型
    func updateChart(animation: Animation = .easeOut(duration: 0.5)) {
        viewDelegateModel.updateChart(animation: animation)
    }
}

// MARK: - WWSwiftUI.LineMarkViewDelegate
extension WWSwiftUI.LineMark: WWSwiftUI.LineMarkViewDelegate {
    
    func lineMarkView<T: WWSwiftUI.LineMarkDataProtocol>(_ lineMarkView: WWSwiftUI.LineMarkView<T>, proxy: ChartProxy, didSelected location: CGPoint) {
        delegate?.lineMark(self, proxy: proxy, didSelected: location)
    }
}
