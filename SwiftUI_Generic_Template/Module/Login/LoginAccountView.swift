//
//  LoginAccountView.swift
//  SwiftUI_Generic_Template
//  http://hdjc8.com/hdjc/swiftUI/
//
//  Created by 王富贵 on 2020/7/14.
//  Copyright © 2020 王富贵. All rights reserved.
//

import SwiftUI

struct LoginAccountView: View {
    
    @State private var account: String = ""
    @State private var password: String = ""
    @State private var showPwd = false
    var isCanLogin: Bool {
        account.count > 0 &&
        password.count > 0
    }
    
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "person")
                TextField("请输入账号", text: $account, onCommit: {
                    
                })
            }
            Divider()
            HStack{
                Image(systemName: "lock")
                if showPwd{
                    TextField("请输入密码", text: $password, onCommit: {
                        
                    })
                }else{
                    SecureField("请输入密码", text: $password, onCommit: {
                        
                    })
                }
                HStack{
                    Button(action: {
                        self.showPwd.toggle()
                    }) {
                        Image(systemName: self.showPwd ?
                    "eye" : "eye.slash")
                    }
                }
            }
            Divider()
            Button(action: {
                print("login action")
            }){
                Text("Login")
                    .foregroundColor(.white)
            }
            // 设置大小和对齐方式
            .frame(width: 100, height: 45, alignment: .center)
            .background(isCanLogin ? Color.blue: Color.gray)
            .cornerRadius(10)
            .disabled(!isCanLogin)
            // 空白填充，如果不使用这个，那么我们的UI会是居中对齐的，如果我们想要填充对齐到某一个方向，就可以使用他
            DismissKeyboardSpacer()
        }
        .padding(.top, 100)
        .padding(.leading)
        .padding(.trailing)
    }
}

struct LoginAccountView_Previews: PreviewProvider {
    static var previews: some View {
        LoginAccountView()
    }
}

