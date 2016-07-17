//
//  WebSocketViewModel.swift
//  Kaze
//
//  Created by HikaruTakahashi on 2016/07/16.
//  Copyright © 2016年 HikaruTakahashi. All rights reserved.
//  docs https://github.com/daltoniam/Starscream
//

import Starscream

class WebSocketViewModel {
    
//    var socket = WebSocket(url: NSURL(string: Const.websocketServerDebug)!)
    var socket = WebSocket(url: NSURL(string: Const.websocketServer)!)
    
    func connect() {
        socket.delegate = self
        socket.connect()
    }
    
    func send(string: String) {
        socket.writeString(string)
    }
    
    func disconnect() {
        socket.disconnect()
    }
}

extension WebSocketViewModel: WebSocketDelegate {
    func websocketDidConnect(ws: WebSocket) {
        print("websocket is connected")
    }
    
    func websocketDidDisconnect(socket: WebSocket, error: NSError?) {
        print("websocket is disconnected: \(error?.localizedDescription)")
    }
    
    func websocketDidReceiveMessage(socket: WebSocket, text: String) {
        print("got some text: \(text)")
    }
    
    func websocketDidReceiveData(socket: WebSocket, data: NSData) {
        print("got some data: \(data.length)")
    }
}
