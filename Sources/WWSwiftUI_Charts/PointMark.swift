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
        public init<T>(model: PointMarkViewModel<T>, symbolSize: CGFloat = 100, useAnnotation: Bool = false) {
            
            let rootView = WWSwiftUI.PointMarkView(model: model, viewDelegateModel: viewDelegateModel, symbolSize: symbolSize, useAnnotation: useAnnotation)
            
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

// MARK: - WWSwiftUI.PointMarkViewDelegate
extension WWSwiftUI.PointMark: WWSwiftUI.PointMarkViewDelegate {
    
    func pointMarkView<T: WWSwiftUI.PointMarkValueProtocol>(_ pointMarkView: WWSwiftUI.PointMarkView<T>, proxy: ChartProxy, didSelected location: CGPoint) {
        delegate?.pointMark(self, proxy: proxy, didSelected: location)
    }
}
