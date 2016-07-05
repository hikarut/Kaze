//
//  ViewModel.swift
//  Kaze
//
//  Created by HikaruTakahashi on 2016/07/05.
//  Copyright © 2016年 HikaruTakahashi. All rights reserved.
//

import CoreMotion

class CoreMotionViewModel {
    
    let cmManager = CMMotionManager()
    
    var xBefore: Double = 0
    var yBefore: Double = 0
    var zBefore: Double = 0
    
    var xDiff: Double = 0
    var yDiff: Double = 0
    var zDiff: Double = 0
    
    init() {
        // 更新間隔のセット
        cmManager.magnetometerUpdateInterval = Const.interval
    }
    
    func showMagnetoData(magnetoData: CMMagnetometerData?, error: NSError?) -> [Double] {
        var result: [Double] = []
        
        guard let data = magnetoData else {
            return result
        }
        
        let x = data.magneticField.x
        let y = data.magneticField.y
        let z = data.magneticField.z
        
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
