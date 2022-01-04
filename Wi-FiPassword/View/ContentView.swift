//
//  ContentView.swift
//  Wi-FiPassword
//
//  Created by 陳峻琦 on 4/1/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var errorMsg: String?
    @State private var wifiName: String?
    @State private var password: String?
    
    var body: some View {
        ZStack {
            Button {
                guard let result = getWiFiPassword(errorMsg: &errorMsg) else {
                    return
                }
                wifiName = result.0 //ssid
                password = result.1 //password
            } label: {
                Text("获取Wi-Fi信息")
                    .padding()
                    .frame(width: 175, height: 100, alignment: .center)
                    .cornerRadius(16)
                    .shadow(radius: 8)
            }
            .padding(50)
        }
        .frame(minWidth: 300, maxWidth: .infinity, minHeight: 100, maxHeight: .infinity, alignment: .center)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
