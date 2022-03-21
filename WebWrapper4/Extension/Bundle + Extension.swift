//
//  Bundle + Extension.swift
//  WebWrapper4
//
//  Created by Yahor Yauseyenka on 18.02.22.
//

import Cocoa

extension Bundle {
    var displayNickname: String? {
        return object(forInfoDictionaryKey: "CFBundleDisplayNickname") as? String
    }
}
