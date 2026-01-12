//
//  Protocol.swift
//  WWSwiftUI_MultiDatePicker
//
//  Created by William.Weng on 2026/1/7.
//

import SwiftUI
import Charts
import WWSwiftUI_MultiDatePicker

// MARK: - 資料協定 (泛型)
public extension WWSwiftUI {
    
    protocol ChartsDataProtocol: Identifiable {
        
        associatedtype Value: Plottable
        
        var id: UUID { get }            // 唯一識別碼
        var label: String { get set }   // 標題文字
        var value: Value { get set }    // 數值
    }
}
