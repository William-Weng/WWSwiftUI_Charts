//
//  SwiftUIView.swift
//  Example
//
//  Created by William.Weng on 2026/1/12.
//

import SwiftUI
import WWSwiftUI_MultiDatePicker
import WWSwiftUI_Charts

final class BarChartsData: WWSwiftUI.BarMarkValueProtocol {
    
    typealias Value = Int

    let id: UUID = UUID()
    var value: Int
    var label: String
    
    init(label: String, value: Int) {
        self.value = value
        self.label = label
    }
}

struct SwiftUIView: View {
    
    @StateObject private var viewModel = WWSwiftUI.BarMarkViewModel<BarChartsData>()
    
    @State private var stepsData: [BarChartsData] = [
        .init(label: "Sun", value: 5900),
        .init(label: "Mon", value: 6500),
        .init(label: "Tue", value: 7200),
        .init(label: "Wed", value: 8100),
        .init(label: "Thu", value: 5600),
        .init(label: "Fri", value: 9000),
        .init(label: "Sat", value: 6200),
    ]
    
    var body: some View {
        
        let barColors: [Color] = [.red, .orange, .yellow, .green, .blue, .purple]
        
        WWSwiftUI.BarMarkView(model: viewModel, barWidth: .ratio(0.5), barColors: barColors)
            .onAppear {
            viewModel.data = stepsData
        }
    }
}

#Preview {
    SwiftUIView()
}
