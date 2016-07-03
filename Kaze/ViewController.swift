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
            
            var x = data.magneticField.x
            var y = data.magneticField.y
            var z = data.magneticField.z
            
            x = round(x*100)/100
            y = round(y*100)/100
            z = round(z*100)/100
            
            label.text = "x:" + String(x) + "/ y:" + String(y) + "/ z:" + String(z)
            
        }
    }
}
