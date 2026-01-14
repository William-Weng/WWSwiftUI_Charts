//
//  Extension.swift
//  WWSwiftUI_Charts
//
//  Created by William.Weng on 2026/1/14.
//

import SwiftUI

public extension View {
    
    /// 畫面的if功能
    /// - Parameters:
    ///   - condition: 判斷式
    ///   - transform: (Self) -> Content
    /// - Returns: some View
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
