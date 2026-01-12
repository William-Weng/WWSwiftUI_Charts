//
//  File.swift
//  WWSwiftUI_Charts
//
//  Created by iOS on 2026/1/12.
//

import Combine
import WWSwiftUI_MultiDatePicker
import WWSwiftUI_Charts

// MARK: - 資料模型 (泛型)
public extension WWSwiftUI {
    
    class ChartsViewModel<T: WWSwiftUI.ChartsDataProtocol>: ObservableObject {
        
        @Published public var datas: [T] = []
        
        public init() {}
    }
}
