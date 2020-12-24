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
    
    func longestPalindrome(_ s: String) -> String {
        let len = s.count
        if len < 2 {
            return s
        }
        
        var maxLen = 1
        
        var res = s.prefix(upTo: s.index(s.startIndex, offsetBy: 1))//(0,1)
        //枚举所有长度大于等于 2 的子串
        for i in 0..<(len - 1) {
            for j in (i + 1)..<len {
                if j - i + 1 > maxLen  && valid(s, left: i, right: j){
                    maxLen = j - i + 1
                    let start = s.index(s.startIndex, offsetBy: i)
                    let end = s.index(s.startIndex, offsetBy: j + 1)
                    res = s[start..<end]
                }
            }
        }
        return String(res)
    }
    
    func valid (_ s:String, left:Int , right:Int ) -> Bool {
        var l = left
        var r = right
        while l < r {
            if s[s.index(s.startIndex, offsetBy: l)] != s[s.index(s.startIndex, offsetBy: r)] {
                return false
            }
            l += 1
            r -= 1
        }
        return true
    }
    
    func longestPalindrome2(_ s:String) -> String {
        let len = s.count
        if len < 2 {
            return s
        }
        var maxLen = 1
        var res = String(s.prefix(upTo: s.index(s.startIndex, offsetBy: 1)))//(0,1)
        // 中心位置枚举到 len - 2 即可
        for i in 0..<len {
            let oddStr = centerSpread(s, left: i, right: i)
            let evenStr = centerSpread(s, left: i, right: i + 1)
            let maxLenStr = oddStr.count > evenStr.count ? oddStr:evenStr
            if maxLenStr.count > maxLen {
                maxLen = maxLenStr.count
                res = maxLenStr
            }
        }
        return res
    }

    func centerSpread(_ s:String, left:Int, right:Int) -> String {
        // left = right 的时候，此时回文中心是一个空隙，回文串的长度是偶数
        // right = left + 1 的时候，此时回文中心是任意一个字符，回文串的长度是奇数
        let len = s.count
        var i = left
        var j = right
        while i >= 0 && j < len {
            if s[s.index(s.startIndex, offsetBy: i)] == s[s.index(s.startIndex, offsetBy: j)] {
                i -= 1
                j += 1
            }else{
                break
            }
        }
        let start = s.index(s.startIndex, offsetBy: i + 1)
        let end = s.index(s.startIndex, offsetBy: j)
        return String(s[start..<end])
    }
    
    //给定一个字符串，逐个翻转字符串中的每个单词。
    func reverseWords(_ s: String) -> String {
        let len = s.count
        if len == 0 {
            return ""
        }
        let arr = s.split(separator: " ")
        if arr.count == 1 {
            return String(arr[0])
        }
        let revers = arr.reversed()
        var str = revers.reduce("") { $0 + " " + $1}
        str.remove(at: str.startIndex)
        return str
    }
    
    func reverseString(_ s: inout [Character]) {
        var left = 0
        var right = s.count - 1
        while left <= right {
            let tmp = s[left]
            s[left] = s[right]
            s[right] = tmp
            
            left += 1
            right -= 1
        }
    }
    
    func arrayPairSum(_ nums: [Int]) -> Int {
        return nums.sorted().enumerated().filter { $0.offset % 2 == 0 }.reduce(0, { $0 + $1.element })
    }
    
    //双指针
    func twoSum(_ numbers: [Int], _ target: Int) -> [Int] {
        var left = 0
        var right = numbers.count - 1
        
        while left < right {
            if numbers[left] + numbers[right] == target {
                return [left + 1, right + 1]
            }else if numbers[left] + numbers[right] > target {
                right -= 1
            }else{
                left += 1
            }
        }
        return []
    }
    
    //二分查找
    func twoSum1(_ numbers: [Int], _ target: Int) -> [Int] {
        for i in 0 ..< numbers.count {
            var low = i + 1
            var high = numbers.count - 1
            while low <= high {
                let mid = (high - low) / 2 + low
                if numbers[mid] == target - numbers[i] {
                    return [i + 1, mid + 1]
                } else if (numbers[mid] > target - numbers[i]) {
                    high = mid - 1
                } else {
                    low = mid + 1
                }
            }
        }
        return [-1, -1]
    }


    
    //哈希表
    func twoSum2(_ numbers: [Int], _ target: Int) -> [Int] {
        var map = [Int: Int]()
        for i in 0..<numbers.count {
            if map[target - numbers[i]] != nil {
                return [map[target - numbers[i]]!, i + 1]
            }
            map[numbers[i]] = i + 1
        }
        return [-1, -1]
    }
    
    /*移除元素
    给你一个数组 nums 和一个值 val，你需要 原地 移除所有数值等于 val 的元素，并返回移除后数组的新长度。
    不要使用额外的数组空间，你必须仅使用 O(1) 额外空间并 原地 修改输入数组。
    元素的顺序可以改变。你不需要考虑数组中超出新长度后面的元素。*/
    func removeElement(_ nums: inout [Int], _ val: Int) -> Int {
        let n = nums.count
        var slow = 0
        if n == 0 {
            return 0
        }else{
            for i in 0..<n {
                if nums[i] != val {
                    nums[slow] = nums[i]
                    slow += 1
                }
            }
        }
        return slow
    }
    
    func removeElement1(_ nums: inout [Int], _ val: Int) -> Int {
        var n = nums.count
        var i = 0
        while i < n {
            if nums[i] == val {
                nums[i] = nums[n - 1]
                n -= 1
            } else {
                i += 1
            }
        }
        return n
    }

}
