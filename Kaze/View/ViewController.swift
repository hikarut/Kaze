//
//  ViewController.swift
//  Kaze
//
//  Created by HikaruTakahashi on 2016/07/02.
//  Copyright © 2016年 HikaruTakahashi. All rights reserved.
//

import UIKit
import LTMorphingLabel
import Chameleon
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    let disposeBag = DisposeBag()
    
    let magnetoMeterViewModel = MagnetoMeterViewModel()
    let websocketViewModel = WebSocketViewModel()
    
    @IBOutlet weak var label: LTMorphingLabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 結果を表示するラベル
        label.morphingEffect = .Anvil
        
        // ボタンの初期設定
        setButtonInit()
        
        // スタートボタン
        startButton.rx_tap
            .subscribeNext { [unowned self] _ in
                // 磁力センサーの開始
                self.magnetoMeterViewModel.startMagnetoMeter()
                // websocketの開始
                self.websocketViewModel.connect()
                // スタートボタンの無効化
                self.disableStartButton()
            }
            .addDisposableTo(disposeBag)
        
        // ストップボタン
        stopButton.rx_tap
            .subscribeNext { [unowned self] _ in
                // 磁力センサーの終了
                self.magnetoMeterViewModel.stopMagnetoMeter()
                // websocketの終了
                self.websocketViewModel.disconnect()
                // ストップボタンの無効化
                self.disableStopButton()
            }
            .addDisposableTo(disposeBag)
        
        // イベントの取得
        _ = magnetoMeterViewModel.event.subscribe(
            onNext: { value in
                // 通常イベント発生時の処理
                
                // ラベルに表示
                self.label.text = String(value)
                
                // websocketでデータを送信
                self.websocketViewModel.send(String(value))
            },
            onError: { error in
                // エラー発生時の処理
            },
            onCompleted: {
                // 完了時の処理
            })
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
    
    func disableStartButton() {
        // スタートボタンを無効にする
        startButton.enabled = false
        startButton.backgroundColor = FlatGray()
        
        // ストップボタンを有効にする
        stopButton.enabled = true
        stopButton.backgroundColor = FlatRed()
    }
    
    func disableStopButton() {
        // スタートボタンを無効にする
        startButton.enabled = true
        startButton.backgroundColor = FlatRed()
        
        // ストップボタンを有効にする
        stopButton.enabled = false
        stopButton.backgroundColor = FlatGray()
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        // 全画面を許可
        return .All
    }
}
