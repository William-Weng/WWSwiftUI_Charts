//
//  File.swift
//  Example
//
//  Created by iOS on 2026/1/13.
//

import SwiftUI
import WWSwiftUI_MultiDatePicker
import WWSwiftUI_Charts

struct SwiftUIView2: View {
    
    @State var taipeiData: [LineChartsValue] = []
    @State var hkData: [LineChartsValue] = []
    
    @StateObject private var viewModel = WWSwiftUI.LineMarkViewModel<LineChartsData>()
    
    var body: some View {
        
        WWSwiftUI.LineMarkView<LineChartsData>(model: viewModel, orientation: .vertical).onAppear {
            
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
                .init(label: "台北", data: taipeiData),
                .init(label: "香港", data: hkData)
            ]
        }
    }
}

#Preview {
    SwiftUIView2()
}
