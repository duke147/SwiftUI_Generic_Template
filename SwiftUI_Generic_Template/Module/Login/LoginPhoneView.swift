//
//  LoginPhoneView.swift
//  手机登录页
//
//  Created by 王富贵 on 2020/7/14.
//  Copyright © 2020 王富贵. All rights reserved.
//

import SwiftUI

struct LoginPhoneView: View {
    // 是否登录
    @State var login: Bool = false
    // 是否注册
    @State var signup: Bool = false
    
    // 保存手机使用
     @State private var phoneNumber: String = ""
    // 验证码
     @State private var code: String = ""
    // 是否开始输入手机号了
     @State private var phoneNumIsEdit = false
    // 是否开始输入验证码了
    @State private var codeIsEdit = false
    // 倒计时的时候使用
     @State private var timer: Timer?
    // 倒计时的时间
     @State private var countDown = 60
    // 判断是不是手机号
     var isPhoneNum: Bool {
         if phoneNumIsEdit {
             return phoneNumber.count == 11
         }
         return true
     }
    // 判断是不是验证码
     var isCode: Bool {
         if codeIsEdit {
             return code.count == 4
         }
         return true
     }
    // 是否可以登录了（控制按钮是否可以点击）
     var isCanLogin: Bool {
         isPhoneNum && isCode
     }
     var body: some View {
        VStack(alignment: .center, spacing: 22, content: {
            Image("devishyns")
                .resizable()
                .frame(width: 80, height: 80)
                .padding(.bottom, 15)
            // 手机号
            HStack{
                Image(systemName: "person.fill")
                    .resizable()
                    .frame(width: 20, height: 20)
                
                TextField("手机号", text: $phoneNumber)
                    .padding(.leading, 12)
                    .font(.system(size: 20))
            }.padding(12)
            .background(Color("Color"))
            .cornerRadius(20)
            
            // 验证码
            HStack{
                Image(systemName: "lock.fill")
                    .resizable()
                    .frame(width: 20, height: 20)
                
                TextField("验证码", text: $code)
                    .padding(.leading, 12)
                    .font(.system(size: 20))
                // 获取验证码
                Button(action: {
                    // get code
                }, label: {Text("获取验证码")})
                
                
            }.padding(12)
            .background(Color(""))
            .cornerRadius(20)
            
            // 登录
            HStack{
                Button(action: {
                   self.login.toggle()
                }) {
                    Text("登录")
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 200)
                }
                .background(Color("BtnColor"))
                    .cornerRadius(8)
                    .shadow(radius: 2)
            }.padding(12)
            .background(Color(""))
            .cornerRadius(20)
            
            
            // 忘记密码
            HStack{
                Button(action: {
                    
                }) {
                    Text("忘记密码？")
                        .foregroundColor(Color("FontColor"))
                }
                Spacer()
            }
            
        }).padding(.horizontal, 18)
        
        
        
//         VStack {
//             VStack {
//                 HStack {
//                     Image(systemName: "phone.down.circle")
//                         .rotationEffect(Angle(degrees: 90))
//
//                     PQTextField(placeholder: "请输入号码", maxLength: 11,text: phoneNumber, onEditing: { tf in
//                        self.phoneNumIsEdit = true
//                        self.phoneNumber = tf.text ?? ""
//                     }, onCommit:  { tf in
//                        self.phoneNumIsEdit = false
//                        self.phoneNumber = tf.text ?? ""
//                     })
//                    .frame(height: 40)
//                 }
//                 if !isPhoneNum {
//                     Text("手机号码应该是11位数字")
//                         .font(.caption)
//                         .foregroundColor(.red)
//                 }
//                 Divider()
//             }
             
//             VStack {
//                 HStack {
//                     PQTextField(placeholder: "请输入验证码", maxLength: 4, text: code, onEditing: { tf in
//                        self.codeIsEdit = true
//                        self.code = tf.text ?? ""
//                     }, onCommit: { tf in
//                        self.codeIsEdit = false
//                        self.code = tf.text ?? ""
//                     })
//                         .frame(height: 40)
//                     Button(action: {
//                         // get code
//                     }, label: {
//                         Text((countDown == 60) ? "获取验证码" : "请\(countDown)s之后重试")
//                     }).disabled(countDown != 60 || phoneNumber.count != 11)
//                 }
//                 if !isCode {
//                     Text("请输入正确的验证码(4位数字)")
//                         .font(.caption)
//                         .foregroundColor(.red)
//                         .frame(alignment: .top)
//                 }
//
//                 Divider()
//             }
//
//             Button(action: {
//                 print("login action", self.phoneNumber, self.code)
//             }) {
//                 Text("Login")
//                     .foregroundColor(.white)
//             }.frame(width: 100, height: 45, alignment: .center)
//                 .background(isCanLogin ? Color.blue: Color.gray)
//                 .cornerRadius(10)
//                 .disabled(!isCanLogin)
//
//             DismissKeyboardSpacer()
//         }
//            // 视图加载的时候调用
//         .onAppear {
//             self.createTimer()
//         }
//            // 视图消失的时候调用
//         .onDisappear {
//             self.invalidate()
//         }
//         .padding()
         
     }
     // 创建定时器
     private func createTimer() {
        if timer == nil {
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (t) in
                if self.countDown < 0 {
                    self.countDown = 0
                    t.invalidate()
                }
                self.countDown -= 1
            })
            // 先不触发定时器
            timer?.fireDate = .distantFuture
        }
     }
     // 销毁定时器
     private func invalidate() {
        timer?.invalidate()
     }
}

struct LoginPhoneView_Previews: PreviewProvider {
    static var previews: some View {
        LoginPhoneView()
    }
}
