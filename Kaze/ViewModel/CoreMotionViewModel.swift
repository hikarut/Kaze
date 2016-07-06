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
    
    init() {
    }
    
    func getMotionDiff(x: Double, y: Double, z: Double) -> [Double] {
        var result: [Double] = []
        
        xDiff = round((x - xBefore)*100)/100
        yDiff = round((y - yBefore)*100)/100
        zDiff = round((z - zBefore)*100)/100
        
        xBefore = x
        yBefore = y
        zBefore = z
        
        result.append(xDiff)
        result.append(yDiff)
        result.append(zDiff)
        
        return result

    }
    
}
