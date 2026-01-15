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

        var label: String { get set }   // 標題文字 (分類)
        var data: [Data] { get set }    // 數值
    }
    
    protocol PointMarkValueProtocol: ChartsDataProtocol {
        
        associatedtype ValueX: Plottable
        associatedtype ValueY: Plottable

        var label: String { get set }   // 標題文字 (分類)
        var xValue: ValueX { get set }  // x軸的值
        var yValue: ValueY { get set }  // y軸的值
    }
}

// MARK: - 數值協定
public extension WWSwiftUI {
    
    protocol BarMarkDelegate: AnyObject {
        
        /// 點擊到時的反應
        func barMark<T: BarMarkValueProtocol>(_ barMark: BarMark<T>, proxy: ChartProxy, didSelected location: CGPoint)
    }
    
    protocol LineMarkDelegate: AnyObject {
        
        /// 點擊到時的反應
        func lineMark<T: LineMarkDataProtocol>(_ lineMark: LineMark<T>, proxy: ChartProxy, didSelected location: CGPoint)
    }
    
    protocol PointMarkDelegate: AnyObject {
        
        /// 點擊到時的反應
        func pointMark<T: PointMarkValueProtocol>(_ pointMark: PointMark<T>, proxy: ChartProxy, didSelected location: CGPoint)
    }
}

// MARK: - 數值協定 (SwiftUI => UIKit)
extension WWSwiftUI {
    
    protocol BarMarkViewDelegate: ObservableObject {
        func barMarkView<T: BarMarkValueProtocol>(_ barMarkView: WWSwiftUI.BarMarkView<T>, proxy: ChartProxy, didSelected location: CGPoint)
    }
    
    protocol LineMarkViewDelegate: ObservableObject {
        func lineMarkView<T: LineMarkDataProtocol>(_ lineMarkView: WWSwiftUI.LineMarkView<T>, proxy: ChartProxy, didSelected location: CGPoint)
    }
    
    protocol PointMarkViewDelegate: ObservableObject {
        func pointMarkView<T: PointMarkValueProtocol>(_ pointMarkView: WWSwiftUI.PointMarkView<T>, proxy: ChartProxy, didSelected location: CGPoint)
    }
}
