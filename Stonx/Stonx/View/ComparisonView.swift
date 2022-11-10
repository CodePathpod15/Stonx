//
//  ComparisonView.swift
//  Stonx
//
//  Created by Angel Zambrano on 11/9/22.
//

import UIKit


class ComparisonView: UIView {
    
    let verticalSV: VerticalSV = {
        let sv = VerticalSV()
        sv.axis = .vertical
        sv.spacing = 4
        return sv
    }()
    
    // the ticker
    func configureLeftSideOfContentView(
        ticker: String,
        price: Double = 0,
        about: String = "",
        type: String = "",
        marketCap: String = "",
        volume: String = " ",
        PERatio: String=" ",
        EPS: String = "") {
        
        // editing the left side
        verticalSV.editLeftSide(tickerName: ticker, price: price, about: about, type: type, marketCap: marketCap, volume: volume, PERatio: PERatio, EPS: EPS)
    }
    
    // configuinr the right side of the stockview
    func configureRightSideOfStockView(
        ticker: String,
        price: Double = 0,
        about: String = "",
        type: String = "",
        marketCap: String = "",
        volume: String = " ",
        PERatio: String=" ",
        EPS: String = "") {
            
        verticalSV.editRightSide(tickerName: ticker, price: price, about: about, type: type, marketCap: marketCap, volume: volume, PERatio: PERatio, EPS: EPS)
    }
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(verticalSV)
        
        verticalSV.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
