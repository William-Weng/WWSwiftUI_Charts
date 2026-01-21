//
//  Charts.swift
//  WWSwiftUI_MultiDatePicker
//
//  Created by William.Weng on 2026/1/15.
//

import UIKit
import SwiftUI
import Charts
import WWSwiftUI_MultiDatePicker

// MARK: - 散點圖
public extension WWSwiftUI {
    
    class PointMark<T: PointMarkValueProtocol>: WWSwiftUI.`Protocol` {
        
        public let hostingController: UIHostingController<AnyView>
        
        public var view: UIView { hostingController.view }
        public weak var delegate: WWSwiftUI.PointMarkDelegate?
        
        private var viewDelegateModel = PointMarkViewDelegateModel()
        
        /// [初始化設定](https://juejin.cn/post/7566208104909864996)
        /// - Parameters:
        ///   - model: PointMarkViewModel<T>
        ///   - symbolSize: 散點的大小
        ///   - useAnnotation: 是否顯示數值文字
        ///   - displayMode: 顯示模式
        public init<T>(model: PointMarkViewModel<T>, symbolSize: CGFloat = 100, useAnnotation: Bool = false, displayMode: WWSwiftUI.PointMarkDisplayMode = .full) {
            
            let rootView = WWSwiftUI.PointMarkView(model: model, viewDelegateModel: viewDelegateModel, symbolSize: symbolSize, useAnnotation: useAnnotation)
            
            hostingController = UIHostingController(rootView: AnyView(rootView))
            viewDelegateModel.setDelegate(self)
            viewDelegateModel.setDisplayMode(displayMode)
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
public extension WWSwiftUI.PointMark {
    
    /// 產生更新動畫
    /// - Parameter animation: 動畫類型
    func updateChart(animation: Animation = .easeOut(duration: 0.5)) {
        viewDelegateModel.updateChart(animation: animation)
    }
}

// MARK: - WWSwiftUI.PointMarkViewDelegate
extension WWSwiftUI.PointMark: WWSwiftUI.PointMarkViewDelegate {
    
    func pointMarkView<T: WWSwiftUI.PointMarkValueProtocol>(_ pointMarkView: WWSwiftUI.PointMarkView<T>, proxy: ChartProxy, didSelected location: CGPoint) {
        delegate?.pointMark(self, proxy: proxy, didSelected: location)
    }
}
