# WWSwiftUI+Charts
[![Swift-5.7](https://img.shields.io/badge/Swift-5.7-orange.svg?style=flat)](https://developer.apple.com/swift/) [![iOS-16.0](https://img.shields.io/badge/iOS-16.0-pink.svg?style=flat)](https://developer.apple.com/swift/) ![TAG](https://img.shields.io/github/v/tag/William-Weng/WWSwiftUI_Charts) [![Swift Package Manager-SUCCESS](https://img.shields.io/badge/Swift_Package_Manager-SUCCESS-blue.svg?style=flat)](https://developer.apple.com/swift/) [![LICENSE](https://img.shields.io/badge/LICENSE-MIT-yellow.svg?style=flat)](https://developer.apple.com/swift/)

### [Introduction - 簡介](https://swiftpackageindex.com/William-Weng)
- [Transfer SwiftUI's Charts to UIKit.](https://developer.apple.com/documentation/Charts)
- [將SwiftUI的圖表功能轉給UIKit使用。](https://www.appcoda.com.tw/swiftui-line-charts/)

![](https://github.com/user-attachments/assets/f52b2377-9dd6-465c-9f6f-1ea93f223298)

### [Installation with Swift Package Manager](https://medium.com/彼得潘的-swift-ios-app-開發問題解答集/使用-spm-安裝第三方套件-xcode-11-新功能-2c4ffcf85b4b)
```bash
dependencies: [
    .package(url: "https://github.com/William-Weng/WWSwiftUI_Charts.git", .upToNextMajor(from: "1.2.1"))
]
```

### 可用函式 (Function)
|函式|功能|
|-|-|
|BarMark(model:barWidth:barColors:useAnnotation:orientation:)|初始化 (柱狀圖)|
|LineMark(model:lineWidth:lineColors:useAnnotation:unit:orientation:)|初始化 (折線圖)|
|PointMark(model:symbolSize:useAnnotation:)|初始化 (散點圖)|

### 可用函式 (Delegate)
|函式|功能|
|-|-|
|barMark(_:proxy:didSelected:)|點擊圖表的反應 (柱狀圖)|
|lineMark(_:proxy:didSelected:)|點擊圖表的反應 (折線圖)|
|pointMark(_:proxy:didSelected:)|點擊圖表的反應 (散點圖)|
|move(toParent:on:)|移動到UIViewController上|
|updateChart(animation:)|產生更新動畫|

### Example (UIKit)
```swift
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
        guard let item = proxy.value(at: location, as: (Int, Int).self) else { return }
        print(item)
    }
}

extension ViewController: WWSwiftUI.PointMarkDelegate {
    
    func pointMark<T: WWSwiftUI.PointMarkValueProtocol>(_ pointMark: WWSwiftUI.PointMark<T>, proxy: ChartProxy, didSelected location: CGPoint) {
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
```

### Example (SwiftUI)
```swift
struct SwiftUIView: View {
    
    @StateObject private var viewModel = WWSwiftUI.BarMarkViewModel<ChartsData>()
    
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
        
        WWSwiftUI.BarMarkView(model: viewModel, barWidth: .ratio(0.5), barColors: barColors).onAppear {
            viewModel.data = stepsData
        }
    }
}

#Preview {
    SwiftUIView()
}
```

### Example (SwiftUI)
```swift
import SwiftUI
import WWSwiftUI_MultiDatePicker
import WWSwiftUI_Charts

struct SwiftUIView2: View {
    
    @State var taipeiData: [LineChartsValue] = []
    @State var hkData: [LineChartsValue] = []
    
    @StateObject private var viewModel = WWSwiftUI.LineMarkViewModel<LineChartsData>()
    
    var body: some View {
    
        let lineColors: [Color] = [.red, .orange, .yellow, .green, .blue, .purple]
        
        WWSwiftUI.LineMarkView<LineChartsData>(model: viewModel, lineWidth: 3.0, lineColors: lineColors).onAppear {
            
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
```

### Example (SwiftUI)

```swift
import SwiftUI
import WWSwiftUI_MultiDatePicker
import WWSwiftUI_Charts

struct SwiftUIView3: View {
        
    @StateObject private var viewModel = WWSwiftUI.PointMarkViewModel<PointChartsData>()
    
    @State private var pointsData: [PointChartsData] = [
        .init(label: "Taipei", xValue: 16, yValue: 26),
        .init(label: "Taipei", xValue: 23, yValue: 32),
        .init(label: "Taipei", xValue: 15, yValue: 16),
        .init(label: "Hong Kong", xValue: 22, yValue: 25),
        .init(label: "Hong Kong", xValue: 10, yValue: 5),
    ]
    
    var body: some View {
        WWSwiftUI.PointMarkView(model: viewModel)
            .onAppear() {
                viewModel.data = pointsData
            }
    }
}

#Preview {
    SwiftUIView3()
}
```
