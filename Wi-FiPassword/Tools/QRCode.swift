//
//  QRCode.swift
//  Wi-FiPassword
//
//  Created by 陳峻琦 on 4/1/2022.
//

import Foundation

/*
 下面代码来自
 https://github.com/aschuch/QRCode
 其他资料
 https://stackoverflow.com/questions/61589783/resize-ciimage-to-an-exact-size
 https://nshipster.com/image-resizing/
 */

import SwiftUI

/// QRCode generator
public struct QRCode {
    
    /**
    The level of error correction.
    
    - Low:      7%
    - Medium:   15%
    - Quartile: 25%
    - High:     30%
    */
    public enum ErrorCorrection: String {
        case Low = "L"
        case Medium = "M"
        case Quartile = "Q"
        case High = "H"
    }
    
    // 生成的QRCode中包含的数据
    public let data: Data
    
    // 输出的前景色
    // 默认为黑色
    public var color = CIColor(red: 0, green: 0, blue: 0)
    
    // 输出的背景色
    // 默认为白色
    public var backgroundColor = CIColor(red: 1, green: 1, blue: 1)
    
    // 输出的大小
    public var size = CGSize(width: 200, height: 200)
    
    // 错误修正。默认值为".Low"
    public var errorCorrection = ErrorCorrection.Low
    
    // MARK: Init
    
    public init(_ data: Data) {
        self.data = data
    }
    
    public init?(_ string: String) {
        if let data = string.data(using: .isoLatin1) {
            self.data = data
        } else {
            return nil
        }
    }
    
    public init?(_ url: URL) {
        if let data = url.absoluteString.data(using: .isoLatin1) {
            self.data = data
        } else {
            return nil
        }
    }
    
    // MARK: 生成二维码
    
    public var image: NSImage? {
        guard var image = ciImage else { return nil }
        
        let scale = size.height / image.extent.height
        image = image.transformed(by: CGAffineTransform(scaleX: scale, y: scale))
        
        let rep = NSCIImageRep(ciImage: image)
        let nsImage = NSImage(size: rep.size)
        nsImage.addRepresentation(rep)
        return nsImage
    }
    
    // The QRCode's CIImage representation
    public var ciImage: CIImage? {
        // Generate QRCode
        guard let qrFilter = CIFilter(name: "CIQRCodeGenerator") else { return nil }
        
        qrFilter.setDefaults()
        qrFilter.setValue(data, forKey: "inputMessage")
        qrFilter.setValue(self.errorCorrection.rawValue, forKey: "inputCorrectionLevel")
        
        // Color code and background
        guard let colorFilter = CIFilter(name: "CIFalseColor") else { return nil }
        
        colorFilter.setDefaults()
        colorFilter.setValue(qrFilter.outputImage, forKey: "inputImage")
        colorFilter.setValue(color, forKey: "inputColor0")
        colorFilter.setValue(backgroundColor, forKey: "inputColor1")
        
        return colorFilter.outputImage
    }
}


