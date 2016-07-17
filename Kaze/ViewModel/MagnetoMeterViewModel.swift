//
//  ViewModel.swift
//  Kaze
//
//  Created by HikaruTakahashi on 2016/07/05.
//  Copyright © 2016年 HikaruTakahashi. All rights reserved.
//

import Foundation
import CoreMotion

class MagnetoMeterViewModel {
    
    let cmManager = CMMotionManager()
    
    var xBefore: Double = 0
    var yBefore: Double = 0
    var zBefore: Double = 0
    
    var xDiff: Double = 0
    var yDiff: Double = 0
    var zDiff: Double = 0
    
    func getMagnetoMeterDiff(x: Double, y: Double, z: Double) -> Double {
        var diffSum: Double = 0.0
        
        if xBefore == 0 && yBefore == 0 && zBefore == 0 {
            xDiff = 0
            yDiff = 0
            zDiff = 0
        } else {
            // 差分を10分の1にする
            xDiff = round((x - xBefore)*10)/90
            yDiff = round((y - yBefore)*10)/90
            zDiff = round((z - zBefore)*10)/90
            // 2乗で差分をとって2000分の1にする
//            xDiff = round((pow(x, 2) - pow(xBefore, 2))*10)/20000
//            yDiff = round((pow(y, 2) - pow(yBefore, 2))*10)/20000
//            zDiff = round((pow(z, 2) - pow(zBefore, 2))*10)/20000
        }
        
        // 差分の絶対値を合計する
        diffSum = fabs(xDiff) + fabs(yDiff) + fabs(zDiff)
        // 差分を合計する
//        diffSum = xDiff + yDiff + zDiff
        
        // 1以下は0にする
        diffSum = diffSum < 1 ? 0.0 : diffSum
        // 差に強弱をつけるために累乗する
        diffSum = round(diffSum * diffSum * 100)/100
        
        xBefore = x
        yBefore = y
        zBefore = z
        
        return diffSum
    }
    
    func getMagnetoMeterDiffForDebug(x: Double, y: Double, z: Double) -> [Double] {
        var result: [Double] = []
        
        let x = round(x*100)/100
        let y = round(y*100)/100
        let z = round(z*100)/100
                
        result.append(x)
        result.append(y)
        result.append(z)
        
        return result
    }
}
