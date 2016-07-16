//
//  SocketViewModel.swift
//  Kaze
//
//  Created by HikaruTakahashi on 2016/07/16.
//  Copyright © 2016年 HikaruTakahashi. All rights reserved.
//  dosc https://github.com/socketio/socket.io-client-swift
//

import SocketIOClientSwift
import Foundation

class SocketIoViewModel {
    
    var socket: SocketIOClient!
    
    // socketをはる
    func socketConnect() {
        socket = SocketIOClient(socketURL: NSURL(string: Const.socketIoServerDebug)!, options: [.Log(true), .ForcePolling(true)])
        
        socket.connect()
    }
    
    // サーバにデータを送る
    func socketEmit(string: String) {
        socket.emit("send", string)
    }

}
