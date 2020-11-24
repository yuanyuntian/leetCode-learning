//
//  Array.swift
//  leetCode
//
//  Created by Fei Yuan on 2020/11/24.
//

import Foundation

class Array {
    
    /// 数组从左到右依次遍历做为中心索引，注意左右两侧不能在每次遍历反复求和，只进行一个数的增减。
    /// - Parameter nums: 数组
    /// - Returns:
    func pivotIndex(_ nums: [Int]) -> Int {
        let length = nums.count
        guard length > 1 else { return -1 }
        var middle = 0
        // Start form the left
        var sumLeft = 0
        var sumRight = nums.suffix(length - 1).reduce(0, +)
        while sumLeft != sumRight {
            // Refresh sum of left
            sumLeft += nums[middle]
            middle += 1
            guard middle < length else { return -1 }
            // Refresh sum of right
            sumRight -= nums[middle]
        }
        return middle
    }

    //所谓的中心索引 i ，是 其 左侧元素之和 等于 右侧元素之和，而不包括其本身。
    //于是 有 两个公式成立：
    //sum = leftSum+rightSum+num[i]
    //leftSum = rightSum
    //所以我们可以计算出元素总和，然后从左累加，得到leftSum，如果 遇到当前 index 的时候，有 leftSum == sum-leftSum-nums[index]。那么 index 就是 中心索引
    func pivotIndex2(_ nums:[Int]) ->Int {
        let sum = nums.reduce(0) { (v1, v2) -> Int in
            return v1 + v2
        }
        var leftSum = 0;
        for i in 0 ..< nums.count  {
            if leftSum == sum - leftSum - nums[i] {
                return i
            }
            leftSum += nums[i]
        }
        return -1
    }
    
    /*
     给定一个排序数组和一个目标值，在数组中找到目标值，并返回其索引。如果目标值不存在于数组中，返回它将会被按顺序插入的位置。
     你可以假设数组中无重复元素。
     */
    
    func searchInsert(_ nums: [Int], _ target: Int) -> Int {
        return nums.enumerated().first(where: {$0.element >= target})?.offset ?? nums.count
    }
}
