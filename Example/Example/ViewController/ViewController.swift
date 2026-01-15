//
//  ViewController.swift
//  Example
//
//  Created by William.Weng on 2026/1/12.
//

import UIKit
import SwiftUI
import Charts
import WWSwiftUI_MultiDatePicker
import WWSwiftUI_Charts

final class ViewController: UIViewController {
    
    @IBOutlet weak var barChartsView: UIView!
    @IBOutlet weak var lineChartsView: UIView!
    
    private var barCharts: WWSwiftUI.BarMark<ChartsData>!
    private var lineCharts: WWSwiftUI.LineMark<LineChartsData>!
    
    private var barViewModel: WWSwiftUI.BarMarkViewModel<ChartsData> = .init()
    private var lineViewModel: WWSwiftUI.LineMarkViewModel<LineChartsData> = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initBarChart()
        initLineChart()
    }
    
    @IBAction func valueSetting(_ sender: UIBarButtonItem) {
        barChartSetting()
        lineChartSetting()
    }
}

extension ViewController: WWSwiftUI.BarMarkDelegate {
    
    func barMark<T: WWSwiftUI.BarMarkValueProtocol>(_ barMark: WWSwiftUI.BarMark<T>, proxy: ChartProxy, didSelected location: CGPoint) {
        guard let item = proxy.value(at: location, as: (String, Int).self) else { return }
        print(item)
    }
}

extension ViewController: WWSwiftUI.LineMarkDelegate {
    
    func lineMark<T: WWSwiftUI.LineMarkDataProtocol>(_ lineMark: WWSwiftUI.LineMark<T>, proxy: ChartProxy, didSelected location: CGPoint) {
        guard let item = proxy.value(at: location, as: (Date, Int).self) else { return }
        print(item)
    }
}

private extension ViewController {
    
    func initBarChart() {
        
        let barColors: [Color] = [.red, .orange, .yellow, .green, .blue, .purple]
        
        barViewModel.data = [.init(label: "Sun", value: 5900)]
        barCharts = .init(model: barViewModel, barColors: barColors, useAnnotation: true)
        barCharts.move(toParent: self, on: barChartsView)
    }
    
    func initLineChart() {
        lineCharts = .init(model: lineViewModel, useAnnotation: true)
        lineViewModel.data = [.init(label: "Taipei", data: [.init(date: .now, value: 100)])]
        lineCharts.move(toParent: self, on: lineChartsView)
    }
    
    func barChartSetting() {
               
        let stepsData: [ChartsData] = [
            .init(label: "Sun", value: 5900),
            .init(label: "Mon", value: 6500),
            .init(label: "Tue", value: 7200),
            .init(label: "Wed", value: 8100),
            .init(label: "Thu", value: 5600),
            .init(label: "Fri", value: 9000),
            .init(label: "Sat", value: 6200),
        ]
        
        barViewModel.data = stepsData
        barCharts.delegate = self
    }
    
    func lineChartSetting() {
        
        let date1: Date = .now.addingTimeInterval(-86400 * 3)
        let date2: Date = .now.addingTimeInterval(-86400 * 2)
        let date3: Date = .now.addingTimeInterval(-86400 * 1)
        let date4: Date = .now.addingTimeInterval(-86400 * 0)
        
        let taipeiData: [LineChartsValue] = [
            .init(date: date1, value: 20),
            .init(date: date2, value: 35),
            .init(date: date3, value: 8),
            .init(date: date4, value: 25)
        ]
        
        let hkData: [LineChartsValue] = [
            .init(date: date1, value: 10),
            .init(date: date2, value: 25),
            .init(date: date3, value: 18),
            .init(date: date4, value: 35)
        ]

        lineViewModel.data = [
            .init(label: "Taipei", data: taipeiData),
            .init(label: "Hong Kong", data: hkData)
        ]
        
        lineCharts.delegate = self
    }
}
