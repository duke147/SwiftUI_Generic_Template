//
//  ContentView.swift
//  SwiftUI_Generic_Template
//
//  Created by 王富贵 on 2020/7/14.
//  Copyright © 2020 王富贵. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var loginAccountIsActive: Bool = false;
    @State private var loginPhoneIsActive: Bool = false;
    
    var body: some View {
        NavigationView {
            List{
                NavigationLink(
                    destination: LoginAccountView(),
                    isActive: $loginAccountIsActive
                ){
                    Text("使用账户密码登录")
                }
                NavigationLink(
                    destination: LoginPhoneView(), isActive: $loginPhoneIsActive
                    ){
                    Text("使用手机号登录")
                }
            }
            .navigationBarTitle(Text("注册界面"), displayMode: .large)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
