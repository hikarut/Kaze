//
//  SocketViewModel.swift
//  Kaze
//
//  Created by HikaruTakahashi on 2016/07/16.
//  Copyright © 2016年 HikaruTakahashi. All rights reserved.
//

import SocketIOClientSwift
import Foundation

class SocketViewModel {
    
    var socket: SocketIOClient!
    
    func socketConnect() {
        socket = SocketIOClient(socketURL: NSURL(string: Const.socketServerDebug)!, options: [.Log(true), .ForcePolling(true)])
        
        socket.on("connect") { data, ack in
            print("socket connected")
        }
        
        socket.on("disconnect") { data, ack in
            print("socket disconnected!!")
        }
        
        socket.on("send") {data, ack in
            if let cur = data[0] as? Double {
                self.socket.emitWithAck("canUpdate", cur)(timeoutAfter: 0) {data in
                    self.socket.emit("update", ["amount": cur + 2.50])
                }
                
                ack.with("Got your currentAmount", "dude")
            }
        }
        
        socket.connect()
    }
    
    func socketEmit() {
        socket.emit("send", "test")
    }

}
