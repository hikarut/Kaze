//
//  ViewController.swift
//  Kaze
//
//  Created by HikaruTakahashi on 2016/07/02.
//  Copyright © 2016年 HikaruTakahashi. All rights reserved.
//

import UIKit
import CoreMotion
import LTMorphingLabel
import Chameleon
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    let disposeBag = DisposeBag()
    let cmManager = CMMotionManager()
    
    let magnetoMeterViewModel = MagnetoMeterViewModel()
    let websocketViewModel = WebSocketViewModel()
    
    @IBOutlet weak var label: LTMorphingLabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 結果を表示するラベル
        label.morphingEffect = .Anvil
        
        // ボタンの設定
        setButtonInit()
        
        // スタートボタン
        startButton.rx_tap
            .subscribeNext { [unowned self] _ in
                self.startMagnetoMeter()
                self.websocketViewModel.connect()
                
                self.startButton.enabled = false
                self.startButton.backgroundColor = FlatGray()
                self.stopButton.enabled = true
                self.stopButton.backgroundColor = FlatRed()
            }
            .addDisposableTo(disposeBag)
        
        // ストップボタン
        stopButton.rx_tap
            .subscribeNext { [unowned self] _ in
                self.stopMagnetoMeter()
                self.websocketViewModel.disconnect()
                
                self.startButton.enabled = true
                self.startButton.backgroundColor = FlatRed()
                self.stopButton.enabled = false
                self.stopButton.backgroundColor = FlatGray()
            }
            .addDisposableTo(disposeBag)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setButtonInit() {
        startButton.backgroundColor = FlatRed()
        startButton.tintColor = FlatWhite()
        
        stopButton.backgroundColor = FlatGray()
        stopButton.tintColor = FlatWhite()
        stopButton.enabled = false
    }
    
    func startMagnetoMeter() {
        cmManager.magnetometerUpdateInterval = Const.interval
        
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
            let data = magnetoMeterViewModel.getMagnetoMeterDiff(x, y: y, z: z)
            
            // 磁力の変化を表示
            label.text = String(data)
            
            // 差分をwebsocketで送信
            websocketViewModel.send(String(data))
        }
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        // 全画面を許可
        return .All
    }
}
