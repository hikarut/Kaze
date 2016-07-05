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
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let coreMotionModel = CoreMotionViewModel()
        
        // キューで実行するクロージャ
        let handler: CMMagnetometerHandler = {(magnetoData: CMMagnetometerData?, error: NSError?) -> Void in
            let data = coreMotionModel.showMagnetoData(magnetoData, error: error)
            self.setLabelData(data)
        }
        // キューを登録し、スタート
        coreMotionModel.cmManager.startMagnetometerUpdatesToQueue(NSOperationQueue.mainQueue(), withHandler: handler)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setLabelData(data: [Double]) {
        // 磁力の変化を表示
        let xDiff = String(data[0])
        let yDiff = String(data[1])
        let zDiff = String(data[2])
        label.text = "x:" + xDiff + "/ y:" + yDiff + "/ z:" + zDiff
    }
    
}
