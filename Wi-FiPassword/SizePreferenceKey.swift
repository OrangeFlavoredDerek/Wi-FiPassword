//
//  SizePreferenceKey.swift
//  Wi-FiPassword
//
//  Created by 陳峻琦 on 5/1/2022.
//

import Foundation
import SwiftUI

struct SizePreferenceKey: PreferenceKey {
    typealias Value = CGSize
    static var defaultValue: Value = .zero

    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = nextValue()
    }
}
