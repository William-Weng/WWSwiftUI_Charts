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
