//
//  Bundle + Extension.swift
//  WebWrapper4
//
//  Created by Yahor Yauseyenka on 18.02.22.
//

import Cocoa

extension Bundle {
    var displayTitle: String? {
        return object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
    }
}
