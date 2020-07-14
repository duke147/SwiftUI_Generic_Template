//
//  PQTextField.swift
//  swiftui_demo_adam
//
//  解决：
//  键盘无法自动消失
//  没有限制TextField的最大输入长度
//
//  桥接UITextField到SwiftUI
//  继承协议UIViewRepresentable，这个协议就是用来桥接的
//
//  Created by 王富贵 on 2020/7/14.
//  Copyright © 2020 王富贵. All rights reserved.
//

import SwiftUI

struct PQTextField: UIViewRepresentable {
    typealias PQTextFieldClosure = (UITextField) -> Void
    /// placeholder
    var placeholder: String? = nil
    /// max can input length
    var maxLength: Int? = nil
    /// default text
    var text: String? = nil
    /// onEditing
    var onEditing: PQTextFieldClosure?
    /// onCommit
    var onCommit: PQTextFieldClosure?
    /// 配置时使用
    var onConfig: PQTextFieldClosure?
    
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.delegate = context.coordinator
        textField.placeholder = placeholder
        textField.addTarget(context.coordinator, action: #selector(context.coordinator.textChange(textField:)), for: .editingChanged)
        textField.text = text
        onConfig?(textField)
        return textField
    }
    
    func updateUIView(_ tf: UITextField, context: Context) {
        tf.placeholder = placeholder
        tf.text = text
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self, onEditing: onEditing, onCommit: onCommit)
    }
    
    
    //  监听UITextField输入情况，这里要设置他的代理；设置的他的初始值，比如placeholder，
    //  代理类里面的代码就是Swift的部分，和SwiftUI半毛钱关系都没有，具体做的事情就是监听代理，然后通过closure回调出去
    class Coordinator: NSObject, UITextFieldDelegate {
        let textField: PQTextField
        var onEditing: PQTextFieldClosure?
        var onCommit: PQTextFieldClosure?
        
        init(_ tf: PQTextField, onEditing: PQTextFieldClosure?, onCommit: PQTextFieldClosure?) {
            self.textField = tf
            self.onEditing = onEditing
            self.onCommit = onCommit
        }
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            onEditing?(textField)
            var length = range.location + 1
            if string == "", textField.text?.count ?? 0 == range.location + range.length { // 表示是删除
                length -= 1
            }
            if length >= self.textField.maxLength ?? -1 {
                onCommit?(textField)
            }
            
            if let maxLength = self.textField.maxLength, string != "" {
                let value = (textField.text?.count ?? 0) < maxLength
                return value
            }
            
            return true
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            onCommit?(textField)
            onCommit = nil
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            onCommit?(textField)
            onCommit = nil
            return true
        }
        
        @objc
        func textChange(textField: UITextField) {
            onEditing?(textField)
        }
    }
}

struct PQTextField_Previews: PreviewProvider {
    static var previews: some View {
        PQTextField()
    }
}

