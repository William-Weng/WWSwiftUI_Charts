//
//  SwiftUIView2.swift
//  Example
//
//  Created by William.Weng on 2026/1/13.
//

import SwiftUI
import WWSwiftUI_MultiDatePicker
import WWSwiftUI_Charts

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

struct SwiftUIView2: View {
    
    @State var taipeiData: [LineChartsValue] = []
    @State var hkData: [LineChartsValue] = []
    
    @StateObject private var viewModel = WWSwiftUI.LineMarkViewModel<LineChartsData>()
    
    var body: some View {
    
        let lineColors: [Color] = [.red, .orange, .yellow, .green, .blue, .purple]
        
        WWSwiftUI.LineMarkView<LineChartsData>(model: viewModel, lineWidth: 3.0, lineColors: lineColors)
            .onAppear {
            
            let date1: Date = .now.addingTimeInterval(-86400 * 3)
            let date2: Date = .now.addingTimeInterval(-86400 * 2)
            let date3: Date = .now.addingTimeInterval(-86400 * 1)
            let date4: Date = .now.addingTimeInterval(-86400 * 0)
            
            taipeiData = [
                .init(date: date1, value: 20),
                .init(date: date2, value: 35),
                .init(date: date3, value: 8),
                .init(date: date4, value: 25)
            ]
            
            hkData = [
                .init(date: date1, value: 10),
                .init(date: date2, value: 25),
                .init(date: date3, value: 18),
                .init(date: date4, value: 35)
            ]
            
            viewModel.data = [
                .init(label: "Taipei", data: taipeiData),
                .init(label: "Hong Kong", data: hkData)
            ]
        }
    }
}

#Preview {
    SwiftUIView2()
}
