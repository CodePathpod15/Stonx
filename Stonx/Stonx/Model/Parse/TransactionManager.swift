//
//  TransactionManager.swift
//  Stonx
//
//  Created by Angel Zambrano on 11/25/22.
//

import Foundation
import Parse

/// in charrge of commiting transactions such as buying and selling
class TransactionManager {
    // the transaction type
    enum TType {
        case buy, sell
    }
    // the current balance of the useer
    var usrBalance: Double? = nil
    
    init() {

    }

    // updates user balance after transaction
    func unpdateUsrBalance(completion: @escaping (Result<Double?, Error>) -> Void) {
        let user  = PFUser.current()!
        user.fetchInBackground() {obj,err in
            // the main thread

            DispatchQueue.main.async {
                if let obj = obj {

                    let balance = obj.value(forKey: "Balance") as? Double

                    self.usrBalance = balance!.truncate(places: 2)
                    completion(.success(self.usrBalance))
                }
            }

        }

    }

    // creates a transaction
    func createTransaction(latestPrice: Double,tickerSym: String, number: Int, type: TType) {
        let obj = PFObject(className: "user_transaction")
        obj["user"] = PFUser.current()!
        obj["price"] = latestPrice
        obj["ticker_symbol"] = tickerSym
        obj["Quantity"] = number

        if type == .buy {
            obj["purchase"] = true
        } else if type == .sell {
            obj["purchase"] = false
        }

        // TODO: fix the
        obj.saveInBackground { success, error in
            if success {
                // save the transaction
            } else {
                
                return
            }
        }



        // update the user's balance
        if let usrBalance = self.usrBalance {
            self.usrBalance = (type == .buy) ? (usrBalance - (latestPrice * Double(number))) : (usrBalance + (latestPrice * Double(number)))

            let usr = PFUser.current()!
            usr["Balance"] = self.usrBalance

            usr.saveInBackground() { success, error in
                if success {
                    // do nothing
                }
                if let error = error {
                    // throw an error

                }

            }
        }

    }

}
