//
//  Model.swift
//  WWSwiftUI_Charts
//
//  Created by William.Weng on 2026/1/12.
//

import SwiftUI
import WWSwiftUI_MultiDatePicker
import WWSwiftUI_Charts

// MARK: - 資料模型 (泛型)
public extension WWSwiftUI {
    
    class BarMarkViewModel<T: WWSwiftUI.BarMarkValueProtocol>: ObservableObject {
        
        @Published public var data: [T] = []
        
        public init() {}
        
        /// 求出最大項目
        /// - Returns: T?
        public func maxData() -> T? {
            return data.max(by: { $0.value < $1.value })
        }
    }
    
    class LineMarkViewModel<T: WWSwiftUI.LineMarkDataProtocol>: ObservableObject {
        
        @Published public var data: [T] = []
        
        public init() {}
        
        /// 求出最大項目
        /// - Returns: T?
        public func maxData() -> T.Data? {
            
            let maxData = data.compactMap { _data_ in
                _data_.data.max(by: { $0.value < $1.value })
            }.max(by: { $0.value < $1.value })
            
            return maxData
        }
    }
    
    class PointMarkViewModel<T: WWSwiftUI.PointMarkValueProtocol>: ObservableObject {
        
        @Published public var data: [T] = []
        
        public init() {}
        
        /// 求出最大項目
        /// - Returns: T?
        public func maxData() -> T? {
            return data.max(by: { $0.yValue < $1.yValue })
        }
    }
}

// MARK: - Delegate模型
extension WWSwiftUI {
    
    class BarMarkViewDelegateModel: BaseViewDelegateModel {
        
        @Published var delegate: WWSwiftUI.BarMarkViewDelegate?
        
        /// 設定Delegate (觸發 @ObservedObject)
        /// - Parameter delegate: WWSwiftUI.BarMarkViewDelegate?
        func setDelegate(_ delegate: WWSwiftUI.BarMarkViewDelegate?) {
            self.delegate = delegate
            objectWillChange.send()
        }
    }
    
    class LineMarkViewDelegateModel: BaseViewDelegateModel {
        
        @Published var delegate: WWSwiftUI.LineMarkViewDelegate?
        
        /// 設定Delegate (觸發 @ObservedObject)
        /// - Parameter delegate: WWSwiftUI.LineMarkViewDelegate?
        func setDelegate(_ delegate: WWSwiftUI.LineMarkViewDelegate?) {
            self.delegate = delegate
            objectWillChange.send()
        }
    }
    
    class PointMarkViewDelegateModel: BaseViewDelegateModel {
        
        @Published var delegate: WWSwiftUI.PointMarkViewDelegate?
        @Published var displayMode: WWSwiftUI.PointMarkDisplayMode = .full
        
        /// 設定Delegate (觸發 @ObservedObject)
        /// - Parameter delegate: WWSwiftUI.PointMarkViewDelegate?
        func setDelegate(_ delegate: WWSwiftUI.PointMarkViewDelegate?) {
            self.delegate = delegate
            objectWillChange.send()
        }
        
        /// 設定顯示模式
        /// - Parameter displayMode: WWSwiftUI.PointMarkDisplayMode
        func setDisplayMode(_ displayMode: WWSwiftUI.PointMarkDisplayMode) {
            self.displayMode = displayMode
            objectWillChange.send()
        }
    }
}

// MARK: - Delegate模型
extension WWSwiftUI {
        
    class BaseViewDelegateModel: ObservableObject {
        
        @Published var progress: Double = 1.00
        
        init() {}
        
        /// 圖表動畫 (0% ~ 100%)
        /// - Parameter animation: Animation
        func updateChart(animation: Animation) {
            
            progress = 0.0
            
            Task { @MainActor in
                
                let transaction = Transaction(animation: animation)
                
                try await Task.sleep(for: .milliseconds(100))
                withTransaction(transaction) { [unowned self] in progress = 1.0 }
            }
        }
    }
}
