//
//  Functions.swift
//  Wi-FiPassword
//
//  Created by 陳峻琦 on 4/1/2022.
//

import Foundation

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

