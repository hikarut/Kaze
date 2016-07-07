//
//  ViewModel.swift
//  Kaze
//
//  Created by HikaruTakahashi on 2016/07/05.
//  Copyright © 2016年 HikaruTakahashi. All rights reserved.
//

import Foundation

class CoreMotionViewModel {
    
    var xBefore: Double = 0
    var yBefore: Double = 0
    var zBefore: Double = 0
    
    var xDiff: Double = 0
    var yDiff: Double = 0
    var zDiff: Double = 0
    
    func getMotionDiff(x: Double, y: Double, z: Double) -> Double {
        var diffSum: Double = 0.0
        
        if xBefore == 0 && yBefore == 0 && zBefore == 0 {
            xDiff = 0
            yDiff = 0
            zDiff = 0
        } else {
            // 差分を10分の1にする
            xDiff = round((x - xBefore)*10)/100
            yDiff = round((y - yBefore)*10)/100
            zDiff = round((z - zBefore)*10)/100
        }
        
        // 差分の絶対値を合計する
        diffSum = fabs(xDiff) + fabs(yDiff) + fabs(zDiff)
        
        // 1以下は0にする
        diffSum = diffSum < 1 ? 0.0 : diffSum
        
        xBefore = x
        yBefore = y
        zBefore = z
        
        return diffSum
    }
    
}
