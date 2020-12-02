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
    
    //给出一个区间的集合，请合并所有重叠的区间。
    func merge(_ intervals:[[Int]]) ->[[Int]] {
        guard intervals.count > 0 else{
            return []
        }
        var res = [[Int]]()
        let sortArr = intervals.sorted(by: { $0[0] < $1[0]})
        res.append(sortArr[0])
        for index in 1..<sortArr.count  {
            let pre = res[res.count - 1]
            if pre[1] >= sortArr[index][0] {
                if pre[1] < sortArr[index][1] {
                    res[res.count - 1][1] = sortArr[index][1]
                }
            }else{
                res.append(sortArr[index])
            }
            
        }
        return res
    }
    
    /*给你一幅由 N × N 矩阵表示的图像，其中每个像素的大小为 4 字节。请你设计一种算法，将图像旋转 90 度。
     不占用额外内存空间能否做到？
     */
    func rotate(_ matrix: inout [[Int]]) {
        if matrix.count > 0 {
            let n = matrix.count
            let col = matrix[0].count

            var new = [[Int]](repeating: [Int](repeating: 0, count: matrix.count), count: matrix[0].count)
            for i in 0..<n {
                for j in i..<n {
                    new[j][n - i - 1] = matrix[i][j]
                }
            }
            matrix = new
        }
    }
    
    /*
     用翻转代替旋转
     5  1  9 11
      2  4  8 10
     13  3  6  7
     15 14 12 16
     
     作为例子，先将其通过水平轴翻转得到：
     5  1  9 11                 15 14 12 16
     2  4  8 10                 13  3  6  7
    ------------   =水平翻转=>   ------------
    13  3  6  7                  2  4  8 10
    15 14 12 16                  5  1  9 11

     再根据主对角线
     \
     \ 翻转得到：
     15 14 12 16                   15 13  2  5
     13  3  6  7   =主对角线翻转=>   14  3  4  1
      2  4  8 10                   12  6  8  9
      5  1  9 11                   16  7 10 11

     就得到了答案。这是为什么呢？对于水平轴翻转而言，我们只需要枚举矩阵上半部分的元素，和下半部分的元素进行交换，即
     matrix[row][col]→
     水平轴翻转
      matrix[n−row−1][col]
     对于主对角线翻转而言，我们只需要枚举对角线左侧的元素，和右侧的元素进行交换，即
     matrix[row][col]→
     主对角线翻转
      matrix[col][row]
     将它们联立即可得到：
     matrix[row][col]
     ​    
       
     →
     水平轴翻转
      matrix[n−row−1][col]
     →
     主对角线翻转
      matrix[col][n−row−1]
     和方法一、方法二中的关键等式：
     matrix
     new
     ​    
      [col][n−row−1]=matrix[row][col]
     是一致的。
    */
    
    func rotate2(_ matrix: inout [[Int]]) {
        let n = matrix.count
        // 水平翻转
        for i in 0 ..< (n/2) {
            for j in 0..<n {
                (matrix[i][j], matrix[n - i - 1][j]) = (matrix[n - i - 1][j], matrix[i][j])
            }
        }
        //对角线翻转
        for i in 0 ..< n {
            for j in 0..<i {
                (matrix[i][j], matrix[j][i]) = (matrix[j][i], matrix[i][j])
            }
        }
    }
    
    //编写一种算法，若M × N矩阵中某个元素为0，则将其所在的行与列清零。
    func setZeroes(_ matrix: inout [[Int]]) {
        let row = matrix.count
        var IndexPath = [(Int,Int)]()
//        for i in 0..<row {
//            for j in 0..<matrix[0].count {
//                if matrix[i][j] == 0 {
//                    IndexPath.append((i,j))
//                }
//            }
//        }
//        for (row, col) in IndexPath {
//            for j in 0..<matrix[0].count {
//                matrix[row][j] = 0
//            }
//            for i in 0..<matrix.count {
//                matrix[i][col] = 0
//            }
//        }
        
        for i in 0..<matrix.count {
            for j in 0..<matrix[i].count {
                if (matrix[i][j] == 0) {
                    matrix[0][j] = 0;
                    matrix[i][0] = 0;
                }
            }
        }

    }
}
