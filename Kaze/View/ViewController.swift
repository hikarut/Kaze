//
//  ViewController.swift
//  Kaze
//
//  Created by HikaruTakahashi on 2016/07/02.
//  Copyright © 2016年 HikaruTakahashi. All rights reserved.
//

import UIKit
import CoreMotion
//import RxSwift
//import RxCocoa

class ViewController: UIViewController {
    
    let cmManager = CMMotionManager()
    let coreMotionViewModel = CoreMotionViewModel()
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startCoreMotion()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func startCoreMotion() {
        cmManager.magnetometerUpdateInterval = Const.interval
        
        // キューで実行するクロージャ
        let handler: CMMagnetometerHandler = {(magnetoData: CMMagnetometerData?, error: NSError?) -> Void in
            self.showMagnetoData(magnetoData, error: error)
        }
        // キューを登録し、スタート
        cmManager.startMagnetometerUpdatesToQueue(NSOperationQueue.mainQueue(), withHandler: handler)
    }
    
    func showMagnetoData(magnetoData: CMMagnetometerData?, error: NSError?) {
        if let data = magnetoData {
            
            let x = data.magneticField.x
            let y = data.magneticField.y
            let z = data.magneticField.z
            
            // 差分を取得
            let data = coreMotionViewModel.getMotionDiff(x, y: y, z: z)
            
            // 磁力の変化を表示
            let xDiff = String(data[0])
            let yDiff = String(data[1])
            let zDiff = String(data[2])
            label.text = "x:" + xDiff + "/ y:" + yDiff + "/ z:" + zDiff
        }
    }
    
}
