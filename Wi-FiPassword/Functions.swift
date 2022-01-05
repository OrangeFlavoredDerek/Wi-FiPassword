//
//  Functions.swift
//  Wi-FiPassword
//
//  Created by 陳峻琦 on 4/1/2022.
//

import Foundation
import AppKit
import SwiftUI

//MARK: 获取Wi-Fi密码
func getWiFiPassword(errorMsg: inout String?) -> (String, String)? {
    let ssid: String
    errorMsg = nil
    do {
        ssid = try WiFiHelper.getSsid()
    } catch {
        errorMsg = "未获取到 WiFi 信息，请确保当前 Mac 正在链接 WiFI 网络。"
        return nil
    }
   
    guard let password = WiFiHelper.getPassword(ssid: ssid) else {
        errorMsg = "未获取到 Password，请输入正确的管理员账号、密码。"
        return nil
    }
    debugPrint("wifi: \(ssid), password:\(password)")
    return (ssid, password)
}


//MARK: 保存图片
// https://stackoverflow.com/questions/39925248/swift-on-macos-how-to-save-nsimage-to-disk
func saveNSImage(_ nsImage: NSImage) {
    let panel = NSSavePanel()
    panel.title = "保存 WiFi 信息"
    panel.message = "将 WiFi 信息进行保存，便于下次使用"
    panel.allowedFileTypes = ["png", "jpg", "bmp"]
    panel.nameFieldStringValue = "WiFi-Password.png"
    panel.nameFieldLabel = "图片名称（Image Name）"
    panel.begin { (response) in
        switch response {
        case .OK:
            guard let file = panel.url?.path else {
                return
            }
            let destinationURL = URL(fileURLWithPath: file)
            do {
                try nsImage.pngWrite(to: destinationURL, options: .withoutOverwriting)
            } catch {
                debugPrint(error.localizedDescription)
            }
            
        case .cancel:
            debugPrint("cancel")
        default:
            break
        }
    }
}
