//
//  File.swift
//  WWSwiftUI_Charts
//
//  Created by William.Weng on 2026/1/12.
//

import Combine
import WWSwiftUI_MultiDatePicker
import WWSwiftUI_Charts
import Foundation

// MARK: - 資料模型 (泛型)
public extension WWSwiftUI {
    
    class BarMarkViewModel<T: WWSwiftUI.BarMarkValueProtocol>: ObservableObject {
        
        @Published public var data: [T] = []
        
        public init() {}
    }
    
    class LineMarkViewModel<T: WWSwiftUI.LineMarkDataProtocol>: ObservableObject {
        
        @Published public var data: [T] = []
        
        public init() {}
    }
}

// MARK: - Delegate模型
extension WWSwiftUI {
    
    class BarMarkViewDelegateModel: ObservableObject {
        
        @Published var delegate: WWSwiftUI.BarMarkViewDelegate?
        
        init() {}
        
        /// 設定Delegate (觸發 @ObservedObject)
        /// - Parameter delegate: WWSwiftUI.BarMarkViewDelegate?
        func setDelegate(_ delegate: WWSwiftUI.BarMarkViewDelegate?) {
            self.delegate = delegate
            objectWillChange.send()
        }
    }
    
    class LineMarkViewDelegateModel: ObservableObject {
        
        @Published var delegate: WWSwiftUI.LineMarkViewDelegate?
        
        init() {}
        
        /// 設定Delegate (觸發 @ObservedObject)
        /// - Parameter delegate: WWSwiftUI.LineMarkViewDelegate?
        func setDelegate(_ delegate: WWSwiftUI.LineMarkViewDelegate?) {
            self.delegate = delegate
            objectWillChange.send()
        }
    }
}
