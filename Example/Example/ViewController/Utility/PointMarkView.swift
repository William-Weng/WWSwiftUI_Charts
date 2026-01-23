//
//  PointMarkView.swift
//  Example
//
//  Created by William.Weng on 2026/1/15.
//

import SwiftUI
import WWSwiftUI_MultiDatePicker
import WWSwiftUI_Charts

final class PointChartsData: WWSwiftUI.PointMarkValueProtocol {
    
    typealias ValueX = Int
    typealias ValueY = Int
    
    let id: UUID = UUID()

    var label: String
    var xValue: ValueX
    var yValue: ValueY
    
    init(label: String, xValue: ValueX, yValue: ValueY) {
        self.label = label
        self.xValue = xValue
        self.yValue = yValue
    }
}

struct PointMarkViewDemo: View {
        
    @StateObject private var viewModel = WWSwiftUI.PointMarkViewModel<PointChartsData>()
    
    @State private var pointsData: [PointChartsData] = [
        .init(label: "Taipei", xValue: 16, yValue: 26),
        .init(label: "Taipei", xValue: 23, yValue: 32),
        .init(label: "Taipei", xValue: 15, yValue: 16),
        .init(label: "Hong Kong", xValue: 22, yValue: 25),
        .init(label: "Hong Kong", xValue: 10, yValue: 5),
    ]
    
    var body: some View {
        
        let pointColors: [Color] = [.red, .orange, .yellow, .green, .blue, .purple]
        
        WWSwiftUI.PointMarkView(model: viewModel, pointColors: pointColors, useAnnotation: true)
            .onAppear() {
                viewModel.data = pointsData
            }
    }
}

#Preview {
    PointMarkViewDemo()
}
