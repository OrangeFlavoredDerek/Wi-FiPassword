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
    @State var infoViewSize: CGSize = CGSize(width: 500, height: 380)
    
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 20) {
                Button {
                    guard let result = getWiFiPassword(errorMsg: &errorMsg) else {
                        return
                    }
                    wifiName = result.0 //ssid
                    password = result.1 //password
                } label: {
                    Text("获取Wi-Fi信息")
                        .padding()
                        //.frame(width: 175, height: 100, alignment: .center)
                        .cornerRadius(16)
                        .shadow(radius: 8)
                }
                .buttonStyle(.borderedProminent)
                .padding(50)
                
                if wifiName != nil && password != nil {
                    Button {
                        guard let wifiName = wifiName, let password = password else {
                            return
                        }
                        guard let nsImage = WiFiInfoView(wifiName: wifiName, password: password)
                                .snapshot(size: infoViewSize) else {
                                    return
                                }
                        saveNSImage(nsImage)
                    } label: {
                        Text("保存为图片")
                            .padding()
                            //.frame(width: 175, height: 100, alignment: .center)
                            .cornerRadius(16)
                            .shadow(radius: 8)
                    }
                    .buttonStyle(.borderedProminent)
                    .padding(50)
                }
            }
            
            if let errorMsg = errorMsg {
                Text(errorMsg)
                    .foregroundColor(Color.red)
            }
            
            if let wifiName = wifiName, let password = password {
                GeometryReader { geometry in
                    WiFiInfoView(wifiName: wifiName, password: password)
                        .preference(key: SizePreferenceKey.self,
                                    value: geometry.size)
                }
            }
        }
        .frame(minWidth: 600, idealWidth: 600, minHeight: 500, idealHeight: 500, alignment: .center)
        .onPreferenceChange(SizePreferenceKey.self) { preferences in
            self.infoViewSize = preferences
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
