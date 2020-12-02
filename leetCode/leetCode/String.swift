//
//  String.swift
//  leetCode
//
//  Created by yuanf on 2020/12/1.
//

import Foundation


class _String {
    func longestCommonPrefix(_ strs: [String]) -> String {
        if strs.isEmpty {
            return ""
        }else if strs.count == 1 {
            return strs.first ?? ""
        }else {
            var index = 0
            for c in strs[0] {
                for str in strs[1...] {
                    if index >= str.count || c != str[str.index(str.startIndex, offsetBy: index)] {
                        return String(strs[0].prefix(index))
                    }
                }
                index += 1
            }
            return strs[0]
        }
        return ""
    }
}
