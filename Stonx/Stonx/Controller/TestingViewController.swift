//
//  TestingViewController.swift
//  Stonx
//
//  Created by Angel Zambrano on 11/10/22.
//

import UIKit
import Starscream

class TestingViewController: UIViewController, URLSessionDelegate, WebSocketDelegate {
   
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        switch event {
        case .connected(let headers):
          print("connected \(headers)")
        case .disconnected(let reason, let closeCode):
          print("disconnected \(reason) \(closeCode)")
        case .text(let text):
          print("received text: \(text)")
        case .binary(let data):
          print("received data: \(data)")
        case .pong(let pongData):
          print("received pong: \(pongData)")
        case .ping(let pingData):
          print("received ping: \(pingData)")
        case .error(let error):
          print("error \(error)")
        case .viabilityChanged:
          print("viabilityChanged")
        case .reconnectSuggested:
          print("reconnectSuggested")
        case .cancelled:
          print("cancelled")
        }
 
    }
    

    
    // Button
    let button : UIButton = {
        var btn = UIButton()
        btn.backgroundColor = .red
        btn.setTitle("sss", for: .normal)
        return btn
    }()
    
//    private var webSocket : URLSessionWebSocketTask?
    let url = URL(string: "wss://demo.piesocket.com/v3/channel_123?api_key=VCXCEuvhGcBDP7XhiJJUDvR1e1D3eiVjgZ9VRiaV&notify_self")!
    var socket = WebSocket(request: .init(url: URL(string: "wss://demo.piesocket.com/v3/channel_123?api_key=VCXCEuvhGcBDP7XhiJJUDvR1e1D3eiVjgZ9VRiaV&notify_self")!))


    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        /*
         - Create button frame
         - Add button to SubView
         - Set background color
         - Add Button Target
         - Create Session
         - Create WebSocket from the session
         */
        
        button.frame = CGRect(x: self.view.frame.width/2 - 100, y: self.view.frame.width/2, width: 200, height: 100)
        self.view.addSubview(button)
        self.view.backgroundColor = .blue
        button.addTarget(self, action: #selector(closeSession), for: .touchUpInside)
        
        socket.delegate = self
        socket.connect()
        
//        socket.dis
        
//        var request = URLRequest(url: url)
//        request.timeoutInterval = 5
//        let socket = WebSocket(request: request)
//        socket.delegate = self
//        socket.connect()
//
//
//        socket.connect()
        
        

      
        
        
    }
   
    
    //MARK: Close Session
    @objc func closeSession(){
        print("here")
        socket.write(string: "Hey Dude you there")
    }
    
    //MARK: URLSESSION Protocols
    
}
