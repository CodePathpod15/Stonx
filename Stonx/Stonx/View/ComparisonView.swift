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

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(verticalSV)
        
        verticalSV.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor)
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
