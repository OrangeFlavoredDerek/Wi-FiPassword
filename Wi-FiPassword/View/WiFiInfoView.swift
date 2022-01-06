//
//  WiFiInfoView.swift
//  Wi-FiPassword
//
//  Created by 陳峻琦 on 4/1/2022.
//

import Foundation
import SwiftUI

struct WiFiInfoView: View {
    @State var wifiName: String
    @State var password: String
    
    var body: some View {
        VStack {
//            Text("WiFi Login")
//                .padding()
//                .font(.largeTitle)
//                .frame(maxWidth: .infinity, alignment: .center)
//            
            HStack {
                Spacer(minLength: 70)
                if let image = QRCode(WiFiHelper.getQRCodeText(ssid: wifiName, password: password))?.image {
                    Image(nsImage: image)
                        .resizable()
                        .frame(width: 200, height: 200)
                }
                
                Spacer(minLength: 40)
                
                VStack(alignment: .leading) {
                    Spacer()
                    VStack(alignment: .leading) {
                        Text("Wi-Fi: ")
                            .font(Font.system(size: 30))
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text(wifiName)
                            .font(Font.system(size: 40))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .fixedSize()
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .leading) {
                        Text("密码: ")
                            .font(Font.system(size: 30))
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text(password)
                            .font(Font.system(size: 40))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .fixedSize()
                    }
                    Spacer(minLength: 20)
                }
                .padding()
            }
            Spacer(minLength: 40)
        }
        .frame(minWidth: 300, maxWidth: .infinity, minHeight: 100, maxHeight: .infinity, alignment: .center)
    }
}

struct WiFiInfoView_Previews: PreviewProvider {
    static var previews: some View {
        WiFiInfoView(wifiName: "test", password: "test")
    }
}


