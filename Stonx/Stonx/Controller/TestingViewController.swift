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
          // authenticated
            var sockets = """
                {"action": "auth", "key": "PKAQG4B3QL3XEQ97F36G", "secret": "MGBfl24lkc9zIKMgtLTy5BhzKDooh8wXKFMIewqp"}
                """
            socket.write(string: sockets)
            
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
    
    
//    guard var url  = URLComponents(string: "https://www.alphavantage.co/query") else {return}
//
//            let queryItems = [
//                URLQueryItem(name: "function", value: "SYMBOL_SEARCH"),
//                URLQueryItem(name: "keywords", value: searchingString),
//                URLQueryItem(name: "apikey", value: key),
//            ]
//
//
//            url.queryItems = queryItems
            
    
//            var request = URLRequest(url: url.url!)
    
    
//    private var webSocket : URLSessionWebSocketTask?
    
    var socket = WebSocket(request: .init(url: URL(string: "wss://stream.data.alpaca.markets/v2/iex")!))
//    var socket = WebSocket(request: .init(url: URL(string: "wss://stream.data.alpaca.markets/v1beta2/crypto")!))


    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
        button.frame = CGRect(x: self.view.frame.width/2 - 100, y: self.view.frame.width/2, width: 200, height: 100)
        self.view.addSubview(button)
        self.view.backgroundColor = .blue
        button.addTarget(self, action: #selector(closeSession), for: .touchUpInside)
        
        socket.delegate = self
        socket.connect()
    
        
    }
   
    
    //MARK: Close Session
    @objc func closeSession(){
        let sockets = """
        {"action":"subscribe","trades":["AAPL"],"quotes":["AMD","CLDR"],"bars":["AAPL","VOO"]}
        """
         
//        let sockets = """
//            {"action":"subscribe","trades":["BTC/USD"],"quotes":["LTC/USD","ETH/USD"],"bars":["BCH/USD"]}
//            """
        socket.write(string: sockets)
        
    }
    
    //MARK: URLSESSION Protocols
    
}
