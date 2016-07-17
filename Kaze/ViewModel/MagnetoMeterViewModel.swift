//
//  ViewModel.swift
//  Kaze
//
//  Created by HikaruTakahashi on 2016/07/05.
//  Copyright © 2016年 HikaruTakahashi. All rights reserved.
//

import Foundation
import CoreMotion
import RxSwift

class MagnetoMeterViewModel {
    
    let cmManager = CMMotionManager()
    
    var xBefore: Double = 0
    var yBefore: Double = 0
    var zBefore: Double = 0
    
    var xDiff: Double = 0
    var yDiff: Double = 0
    var zDiff: Double = 0
    
    // イベント発生
    private let eventSubject = PublishSubject<Double>()
    var event: Observable<Double> { return eventSubject }
    
    init() {
        cmManager.magnetometerUpdateInterval = Const.interval
    }
    
    func startMagnetoMeter() {
        // キューで実行するクロージャ
        let handler: CMMagnetometerHandler = {(magnetoData: CMMagnetometerData?, error: NSError?) -> Void in
            self.showMagnetoData(magnetoData, error: error)
        }
        // キューを登録し、スタート
        cmManager.startMagnetometerUpdatesToQueue(NSOperationQueue.mainQueue(), withHandler: handler)
    }
    
    func stopMagnetoMeter() {
        cmManager.stopMagnetometerUpdates()
    }
    
    func showMagnetoData(magnetoData: CMMagnetometerData?, error: NSError?) {
        if let data = magnetoData {
            
            let x = data.magneticField.x
            let y = data.magneticField.y
            let z = data.magneticField.z
            
            // 差分を取得
            let data = getMagnetoMeterDiff(x, y: y, z: z)
            // 通知
            eventSubject.onNext(data)
        }
    }
    
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
        }
        
        // 差分の絶対値を合計する
        diffSum = fabs(xDiff) + fabs(yDiff) + fabs(zDiff)
        
        // 1以下は0にする
        diffSum = diffSum < 1 ? 0.0 : diffSum
        // 差に強弱をつけるために累乗する
        diffSum = round(diffSum * diffSum * 100)/100
        
        xBefore = x
        yBefore = y
        zBefore = z
        
        return diffSum
    }
}
