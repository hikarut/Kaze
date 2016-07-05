//
//  ViewController.swift
//  Kaze
//
//  Created by HikaruTakahashi on 2016/07/02.
//  Copyright © 2016年 HikaruTakahashi. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import CoreMotion

class ViewController: UIViewController {
    
    let cmManager = CMMotionManager()
    
    var xBefore: Double = 0
    var yBefore: Double = 0
    var zBefore: Double = 0
    
    var xDiff: Double = 0
    var yDiff: Double = 0
    var zDiff: Double = 0
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 磁気センサー
        cmManager.magnetometerUpdateInterval = 0.1
        
        let handler: CMMagnetometerHandler = {(magnetoData: CMMagnetometerData?, error: NSError?) -> Void in
            self.showMagnetoData(magnetoData, error: error)
        }
        cmManager.startMagnetometerUpdatesToQueue(NSOperationQueue.mainQueue(), withHandler: handler)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func showMagnetoData(magnetoData: CMMagnetometerData?, error: NSError?) {
        if let data = magnetoData {
            
            let x = data.magneticField.x
            let y = data.magneticField.y
            let z = data.magneticField.z
            
            xDiff = round((x - xBefore)*100)/100
            yDiff = round((y - yBefore)*100)/100
            zDiff = round((z - zBefore)*100)/100
            
            xBefore = x
            yBefore = y
            zBefore = z
            
//            label.text = "x:" + String(x) + "/ y:" + String(y) + "/ z:" + String(z)
            // 磁力の変化を表示
            label.text = "x:" + String(xDiff) + "/ y:" + String(yDiff) + "/ z:" + String(zDiff)
            
        }
    }
}
