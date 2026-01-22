//
//  Model.swift
//  WWSwiftUI_Charts
//
//  Created by William.Weng on 2026/1/12.
//

import SwiftUI
import WWSwiftUI_MultiDatePicker
import WWSwiftUI_Charts
import Charts

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
        
        @Published var delegate: BarMarkViewDelegate?
        
        /// 設定Delegate (觸發 @ObservedObject)
        /// - Parameter delegate: BarMarkViewDelegate?
        func setDelegate(_ delegate: BarMarkViewDelegate?) {
            self.delegate = delegate
            objectWillChange.send()
        }
        
        /// 設定輔助線
        /// - Parameter guideLine: ChartGuideLine?
        func setGuideLine(_ guideLine: ChartGuideLine?) {
            self.guideLine = guideLine
            objectWillChange.send()
        }
    }
    
    class LineMarkViewDelegateModel: BaseViewDelegateModel {
        
        @Published var delegate: LineMarkViewDelegate?
        @Published var interpolationMethod: InterpolationMethod = .linear
        
        /// 設定Delegate (觸發 @ObservedObject)
        /// - Parameter delegate: LineMarkViewDelegate?
        func setDelegate(_ delegate: LineMarkViewDelegate?) {
            self.delegate = delegate
            objectWillChange.send()
        }
        
        /// 設定曲線插值選項 (產生平滑曲線效果)
        /// - Parameter method: InterpolationMethod?
        func setInterpolationMethod(_ method: InterpolationMethod) {
            self.interpolationMethod = method
            objectWillChange.send()
        }
        
        /// 設定輔助線
        /// - Parameter guideLine: ChartGuideLine?
        func setGuideLine(_ guideLine: ChartGuideLine?) {
            self.guideLine = guideLine
            objectWillChange.send()
        }
    }
    
    class PointMarkViewDelegateModel: BaseViewDelegateModel {
        
        @Published var delegate: PointMarkViewDelegate?
        @Published var displayMode: PointMarkDisplayMode = .full
        @Published var orientation: NSLayoutConstraint.Axis = .vertical

        /// 設定Delegate (觸發 @ObservedObject)
        /// - Parameter delegate: PointMarkViewDelegate?
        func setDelegate(_ delegate: PointMarkViewDelegate?) {
            self.delegate = delegate
            objectWillChange.send()
        }
        
        /// 設定顯示模式
        /// - Parameter displayMode: PointMarkDisplayMode
        func setDisplayMode(_ displayMode: PointMarkDisplayMode) {
            self.displayMode = displayMode
            objectWillChange.send()
        }
        
        /// 設定輔助線
        /// - Parameter guideLine: ChartGuideLine?
        func setGuideLine(_ guideLine: ChartGuideLine?, orientation: NSLayoutConstraint.Axis) {
            self.guideLine = guideLine
            self.orientation = orientation
            objectWillChange.send()
        }
    }
}

// MARK: - Delegate模型
extension WWSwiftUI {
        
    class BaseViewDelegateModel: ObservableObject {
        
        @Published var progress: Double = 1.00
        @Published var guideLine: ChartGuideLine?
        
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
