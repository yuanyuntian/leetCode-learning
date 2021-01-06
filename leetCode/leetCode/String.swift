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
    /*
    输入: [1,1,0,1,1,1]
    输出: 3
    解释: 开头的两位和最后的三位都是连续1，所以最大连续1的个数是 3.
    注意：
    输入的数组只包含 0 和1。
    输入数组的长度是正整数，且不超过 10,000。
    */
    /*用一个计数器 count 记录 1 的数量，另一个计数器 maxCount 记录当前最大的 1 的数量。
    当我们遇到 1 时，count 加一。
    当我们遇到 0 时：
    将 count 与 maxCount 比较，maxCoiunt 记录较大值。
    将 count 设为 0。
    返回 maxCount。
     */

    func findMaxConsecutiveOnes(_ nums: [Int]) -> Int {
        var count = 0, max = 0
        var i = 0
        while i < nums.count {
            if nums[i] == 1 {
                count += 1
            }else{
                if count > max {
                    max = count
                }
                count = 0
            }
            i += 1
        }
        if count > max {
            max = count
        }
        return max
    }
    
    //双指针
    func findMaxConsecutiveOnes2(_ nums: [Int]) -> Int {
        var i = 0, j = 0, max = 0
        while j < nums.count {
            if nums[j] == 0 {
                if max <= j - i {
                    max = j - i
                    i = j + 1
                }
            }
            if j == nums.count - 1 && nums[j] == 1 {
                if max <= j + 1 - i {
                    max = j + 1 - i
                }
            }
            j += 1
        }
        return max
    }
    
    func minSubArrayLen(_ s: Int, _ nums: [Int]) -> Int {
        let n = nums.count
        if n == 0 {
            return 0
        }
        var ans = Int.max
        var start = 0, end = 0
        var sum = 0
        while end < n {
            sum += nums[end]
            while sum >= s {
                ans = min(ans, end - start + 1)
                sum -= nums[start]
                start += 1
            }
            end += 1
        }
        return ans == Int.max ? 0:ans
    }
}
