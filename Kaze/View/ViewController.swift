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
    let socketViewModel = SocketViewModel()
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var debugLabelX: UILabel!
    @IBOutlet weak var debugLabelY: UILabel!
    @IBOutlet weak var debugLabelZ: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startCoreMotion()
        
        socketViewModel.socketConnect()
        socketViewModel.socketEmit()
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
            label.text = String(data)
            
            // デバッグ用
            let debugData = coreMotionViewModel.getMotionDiffForDebug(x, y: y, z: z)
            debugLabelX.text = "x:" + String(debugData[0])
            debugLabelY.text = "y:" + String(debugData[1])
            debugLabelZ.text = "z:" + String(debugData[2])
        }
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        // 全画面を許可
        return .All
    }
    
}
