//
//  DashboardVCSocket.swift
//  Stonx
//
//  Created by Angel Zambrano on 11/14/22.
//

import UIKit
import Starscream


extension DashboardVCViewController: WebSocketDelegate {
 
    
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
        case .text(var text):
          print("received text: \(text)")
            text.removeAll(where: {$0 == "]" || $0 == "["})
            let mapped = convertToDictionary(text: text)
            
            if let mapped = mapped {
                let t = mapped["T"] as? String
                let m = mapped["msg"] as? String
                
                if (t ?? " ") == "success" && m == "authenticated" {
                    // we can start up dating
                    makeTradeConnections(stocks: self.ownedStocks)
                    
                } //  check for the ticker symbol
                else if ( t ?? " ") == "t" {
        
                    DispatchQueue.main.async {
                        // gives us the ticker symbol
                        guard let s = mapped["S"] as? String else {return}
                        guard let p = mapped["p"] as? Double  else {return}
                        
                        var total: Double = 0
                        
                        self.ownedStocks.forEach({
                        
                            if $0.ticker_symbol == s  {
                                
                                $0.price = p
                                
                            }
                            // getting the price difference to update the new price
                            total += $0.price
                        })
                        
                        self.contentView.configure(stocks: self.ownedStocks)
                        self.contentView.tableView.reloadData()
                        self.contentView.stockPrice.text = String(total)
                
                        }
                }
            }
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
}
