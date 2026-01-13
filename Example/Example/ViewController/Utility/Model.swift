//
//  Model.swift
//  Example
//
//  Created by William.Weng on 2026/1/12.
//

import Foundation
import WWSwiftUI_MultiDatePicker
import WWSwiftUI_Charts

final class ChartsData: WWSwiftUI.BarMarkValueProtocol {
    
    typealias Value = Int

    let id: UUID = UUID()
    var value: Int
    var label: String
    
    init(label: String, value: Int) {
        self.value = value
        self.label = label
    }
}

final class LineChartsValue: WWSwiftUI.LineMarkValueProtocol {
    
    typealias Value = Int
    
    let id: UUID = UUID()
    var date: Date
    var value: Value
    
    init(date: Date, value: Value) {
        self.date = date
        self.value = value
    }
}

final class LineChartsData: WWSwiftUI.LineMarkDataProtocol {
    
    typealias Data = LineChartsValue
    
    let id: UUID = UUID()
    var label: String
    var data: [Data]
    
    init(label: String, data: [Data]) {
        self.label = label
        self.data = data
    }
}
