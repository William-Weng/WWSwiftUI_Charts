# WWSwiftUI_Charts
[![Swift-5.7](https://img.shields.io/badge/Swift-5.7-orange.svg?style=flat)](https://developer.apple.com/swift/) [![iOS-16.0](https://img.shields.io/badge/iOS-16.0-pink.svg?style=flat)](https://developer.apple.com/swift/) ![TAG](https://img.shields.io/github/v/tag/William-Weng/WWSwiftUI_Charts) [![Swift Package Manager-SUCCESS](https://img.shields.io/badge/Swift_Package_Manager-SUCCESS-blue.svg?style=flat)](https://developer.apple.com/swift/) [![LICENSE](https://img.shields.io/badge/LICENSE-MIT-yellow.svg?style=flat)](https://developer.apple.com/swift/)

### [Introduction - 簡介](https://swiftpackageindex.com/William-Weng)
- [Transfer SwiftUI's Charts to UIKit.](https://developer.apple.com/documentation/Charts)
- [將SwiftUI的圖表功能轉給UIKit使用。](https://www.appcoda.com.tw/swiftui-line-charts/)

[](Example.png)

### [Installation with Swift Package Manager](https://medium.com/彼得潘的-swift-ios-app-開發問題解答集/使用-spm-安裝第三方套件-xcode-11-新功能-2c4ffcf85b4b)
```bash
dependencies: [
    .package(url: "https://github.com/William-Weng/WWSwiftUI_Charts.git", .upToNextMajor(from: "1.0.0"))
]
```

### 可用函式 (Function)
|函式|功能|
|-|-|
|init(model:barColors:orientation:)|初始化|

### Example
```swift
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

```
