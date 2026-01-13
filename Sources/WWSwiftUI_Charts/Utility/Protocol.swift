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
        var id: UUID { get }            // 唯一識別碼
    }
    
    protocol BarMarkValueProtocol: ChartsDataProtocol {
        
        associatedtype Value: Plottable
        
        var label: String { get set }   // 標題文字
        var value: Value { get set }    // 數值
    }
    
    protocol LineMarkValueProtocol: ChartsDataProtocol {
        
        associatedtype Value: Plottable
        
        var date: Date { get set }      // 日期
        var value: Value { get set }    // 數值
    }
    
    protocol LineMarkDataProtocol: ChartsDataProtocol {
        
        associatedtype Data: LineMarkValueProtocol

        var label: String { get set }   // 標題文字
        var data: [Data] { get set }    // 數值
    }
}
