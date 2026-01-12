//
//  ViewController.swift
//  Example
//
//  Created by William.Weng on 2026/1/12.
//

import UIKit
import SwiftUI
import WWSwiftUI_MultiDatePicker
import WWSwiftUI_Charts

final class ViewController: UIViewController {
    
    @IBOutlet weak var barChartsView: UIView!
    
    private let barColors: [Color] = [.red, .orange, .yellow, .green, .blue, .purple]
    
    private var viewModel: WWSwiftUI.ChartsViewModel<ChartsData> = .init()
    private var barCharts: WWSwiftUI.Charts<ChartsData>!
    
    @State private var stepsData: [ChartsData] = [
        .init(label: "Sun", value: 5900),
        .init(label: "Mon", value: 6500),
        .init(label: "Tue", value: 7200),
        .init(label: "Wed", value: 8100),
        .init(label: "Thu", value: 5600),
        .init(label: "Fri", value: 9000),
        .init(label: "Sat", value: 6200),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.datas = [.init(label: "Mon", value: 6500)]
        barCharts = .init(model: viewModel, barColors: barColors, orientation: .vertical)
        barCharts.move(toParent: self, on: barChartsView)
    }
    
    @IBAction func valueSetting(_ sender: UIBarButtonItem) {
        viewModel.datas = stepsData
    }
}

