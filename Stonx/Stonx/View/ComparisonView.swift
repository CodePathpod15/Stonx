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
    
    
    func configureLeft(price: Double, volume: String) {
        verticalSV.editLeft(price: price, and: volume)
    }
    
    // the ticker
    /// configures everything on the left side without the
    func configureLeftSideOfContentView(
        tickerName: String,
        about: String?,
        type: String?,
        marketCap: String?,
        volume: String?,
        PERatio: String?,
        EPS: String?) {
        
        verticalSV.editLeftSide(tickerName: tickerName, about: about, type: type, marketCap: marketCap, PERatio: PERatio, EPS: PERatio)

        }
    
    
    // configuinr the right side of the stockview
    func configureRightSideOfStockView(
        tickerName: String ,
        about: String? ,
        type: String? ,
        marketCap: String? ,
        PERatio: String? ,
        EPS: String?) {
            
        verticalSV.editRightSide(tickerName: tickerName, about: about, type: type, marketCap: marketCap, PERatio: PERatio, EPS: PERatio)
    }
    
    
    func configureRight(price: Double, volume: String) {
        verticalSV.editRight(price: price, volume: volume)
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
