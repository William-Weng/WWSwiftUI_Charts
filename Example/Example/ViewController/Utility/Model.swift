//
//  Model.swift
//  Example
//
//  Created by William.Weng on 2026/1/12.
//

import Foundation
import WWSwiftUI_MultiDatePicker
import WWSwiftUI_Charts

class ChartsData: WWSwiftUI.ChartsDataProtocol {
    
    typealias Value = Int

    let id: UUID = UUID()
    var value: Int
    var label: String
    
    init(label: String, value: Int) {
        self.value = value
        self.label = label
    }
}
