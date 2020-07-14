//
//  DismissKeyboard.swift
//  swiftui_demo_adam
//  实现点击空白处隐藏键盘
//  点击空白处，空白处的View是Spacer，Spacer又遵循View协议，那我们可以为View扩展一个隐藏键盘的方法
//  Created by 王富贵 on 2020/7/14.
//  Copyright © 2020 王富贵. All rights reserved.
//

import SwiftUI

extension View {
    func endEditing() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
    }
}

// 为了方便其他的View使用，自定义了一个struct遵从ViewModifier协议
// Text("xxxx")
// .modifier(DismissKeyboard())
struct DismissKeyboard: ViewModifier {
    func body(content: Content) -> some View {
        content.onTapGesture {
            content.endEditing()
        }
    }
}
// DismissKeyboardSpacer()
public struct DismissKeyboardSpacer: View {
    public private(set) var minLength: CGFloat? = nil
    
    public init(minLength: CGFloat? = nil) {
        self.minLength = minLength
    }
    
    public var body: some View {
        ZStack {
            Color.black.opacity(0.001)
                .modifier(DismissKeyboard())
            Spacer(minLength: minLength)
        }
        .frame(height: minLength)
    }
    
}
