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
    @IBOutlet weak var pointChartsView: UIView!

    private var barCharts: WWSwiftUI.BarMark<BarChartsData>!
    private var lineCharts: WWSwiftUI.LineMark<LineChartsData>!
    private var pointCharts: WWSwiftUI.PointMark<PointChartsData>!

    private var barViewModel: WWSwiftUI.BarMarkViewModel<BarChartsData> = .init()
    private var lineViewModel: WWSwiftUI.LineMarkViewModel<LineChartsData> = .init()
    private var pointViewModel: WWSwiftUI.PointMarkViewModel<PointChartsData> = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initBarChart()
        initLineChart()
        initPointChart()
    }
    
    @IBAction func valueSetting(_ sender: UIBarButtonItem) {
        barChartSetting()
        lineChartSetting()
        pointChartSetting()
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

extension ViewController: WWSwiftUI.PointMarkDelegate {
    
    func pointMark<T: WWSwiftUI.PointMarkValueProtocol>(_ pointMark: WWSwiftUI.PointMark<T>, proxy: ChartProxy, didSelected location: CGPoint) {
        guard let item = proxy.value(at: location, as: (Int, Int).self) else { return }
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
    
    func initPointChart() {
        pointCharts = .init(model: pointViewModel, useAnnotation: true)
        pointViewModel.data = [.init(label: "Taipei", xValue: 16, yValue: 26)]
        pointCharts.move(toParent: self, on: pointChartsView)
    }
    
    func barChartSetting() {
        
        let stepsData: [BarChartsData] = [
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
        barCharts.updateChart()
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
        lineCharts.updateChart()
    }
    
    func pointChartSetting() {
        
        pointViewModel.data = [
            .init(label: "Taipei", xValue: 16, yValue: 26),
            .init(label: "Taipei", xValue: 23, yValue: 32),
            .init(label: "Taipei", xValue: 15, yValue: 16),
            .init(label: "Hong Kong", xValue: 22, yValue: 25),
            .init(label: "Hong Kong", xValue: 10, yValue: 5),
        ]
        
        pointCharts.delegate = self
    }
}
