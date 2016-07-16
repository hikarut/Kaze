//
//  SocketViewModel.swift
//  Kaze
//
//  Created by HikaruTakahashi on 2016/07/16.
//  Copyright © 2016年 HikaruTakahashi. All rights reserved.
//

import SocketIOClientSwift
import Foundation

class SocketIoViewModel {
    
    var socket: SocketIOClient!
    
    // socketをはる
    func socketConnect() {
        socket = SocketIOClient(socketURL: NSURL(string: Const.socketServerDebug)!, options: [.Log(true), .ForcePolling(true)])
//        socket = SocketIOClient(socketURL: NSURL(string: Const.socketServer)!, options: [.Log(true), .ForcePolling(true)])
        
        socket.connect()
    }
    
    // サーバにデータを送る
    func socketEmit(string: String) {
        socket.emit("send", string)
    }

}
