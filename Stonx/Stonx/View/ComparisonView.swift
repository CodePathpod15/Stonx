//
//  ComparisonView.swift
//  Stonx
//
//  Created by Angel Zambrano on 11/9/22.
//

import UIKit

class ComparisonView: UIView {
    
    let verticalSV: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 4
        return sv
    }()
    
    let firstHorizontalView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.distribution = .fillEqually
        return sv
    }()
    
    let firstHorizontalLeftVerticalSV: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .center
        return sv
    }()
    
    let FirstSock: UILabel = {
        let lbl = UILabel()
        lbl.text = "META"
        return lbl
    }()
    
    let leftfirstPrice: UILabel = {
        let lbl = UILabel()
        lbl.text = "4070.00"
        lbl.textColor = ColorConstants.green
        return lbl
    }()
    
    let firstHorizontalERighttVerticalSV: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .center
        return sv
    }()
    
    let secondStock: UILabel = {
        let lbl = UILabel()
        lbl.text = "META"
        return lbl
    }()
 
    let rightStockPrice: UILabel = {
        let lbl = UILabel()
        lbl.text = "4070.00"
        lbl.textColor = ColorConstants.green
        return lbl
    }()
    
    
    
    
    let aboutTitle: UILabel = {
        let lbl = UILabel()
        lbl.text = "About"
        lbl.font = FontConstants.boldLargeFont
        lbl.textAlignment = .center
        return lbl
    }()
    
    // this is the 2nd horitzontal SV
    // contains the about me portion
    let secondHorizontalVerticalSV: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.distribution = .fillEqually
        return sv
    }()
    
    let secondtHorizontalLeftVerticalSV: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .center
        return sv
    }()
    
    
    let LeftBiolbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Nabil Bank Limited is a commercial bank in Nepal. Founded in 1984, the bank has branches across the nation and its head office in Kathmandu. Read full bio"
        lbl.textColor = UIColor.systemGray2

        lbl.numberOfLines = 9
        lbl.textAlignment = .center
        return lbl
    }()
    
    let rightBioLBl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Meta Platforms, Inc. develops products that enable people to connect and share with friends and family through mobile devices, PCs, virtual reality headsets, wearables and home devices around the world. The company is headquartered in Menlo Park, California."
        lbl.textColor = UIColor.systemGray2
        lbl.numberOfLines = 9
        lbl.textAlignment = .center
        return lbl
    }()
    
    let righttHorizontalLeftVerticalSV: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .center
        return sv
    }()
    
    let typeTitle: UILabel = {
        let lbl = UILabel()
        lbl.text = "Type"
        lbl.font = FontConstants.boldLargeFont
        lbl.textAlignment = .center
        return lbl
    }()
    
    // the type of the viewcontroller
    
    let thirdHorizontalView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.distribution = .fillEqually
        return sv
    }()
    
    
    let thirdtHorizontalLeftVerticalSV: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .center
        return sv
    }()
    
    let leftTypeLBl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Commercial Bank"
        lbl.numberOfLines = 1
        lbl.textAlignment = .center
        lbl.textColor = UIColor.systemGray2

        return lbl
    }()
    
    let rightTypeLBl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Commercial Bank"
        lbl.textColor = UIColor.systemGray2
        lbl.numberOfLines = 1
        lbl.textAlignment = .center
        return lbl
    }()
    
    
    let thirdtHorizontalrightVerticalSV: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .center
        return sv
    }()
    
    // the markets stats
    let marketCapLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Market Cap"
        lbl.font = FontConstants.boldLargeFont
        lbl.textAlignment = .center
        return lbl
    }()
    
    
    let fouthHorizontalView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.distribution = .fillEqually
        return sv
    }()
    
    let leftMarketCapLabl: UILabel = {
        let lbl = UILabel()
        lbl.text = "1.10B"
        lbl.textColor = UIColor.systemGray2
        lbl.numberOfLines = 1
        lbl.textAlignment = .center
        return lbl
    }()
    
    let fourthHorizontalLeftVerticalSV: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .center
        return sv
    }()
    
    let rightMarketCapLabl: UILabel = {
        let lbl = UILabel()
        lbl.text = "2.3B"
        lbl.textColor = UIColor.systemGray2
        lbl.numberOfLines = 1
        lbl.textAlignment = .center
        return lbl
    }()
    
    let fourthHorizontalRightVerticalSV: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .center
        return sv
    }()
    
    let volumeLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Volume"
        lbl.font = FontConstants.boldLargeFont
        lbl.textAlignment = .center
        return lbl
    }()
    
    let fifthHorizontalView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.distribution = .fillEqually
        return sv
    }()
    
    let leftVolumeLabl: UILabel = {
        let lbl = UILabel()
        lbl.text = "1.12120B"
        lbl.textColor = UIColor.systemGray2
        lbl.numberOfLines = 1
        lbl.textAlignment = .center
        return lbl
    }()
    
    let fifthHorizontalLeftVerticalSV: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .center
        return sv
    }()
    
    let rightVolumeLabl: UILabel = {
        let lbl = UILabel()
        lbl.text = "2.31212B"
        lbl.textColor = UIColor.systemGray2
        lbl.numberOfLines = 1
        lbl.textAlignment = .center
        return lbl
    }()
    
    let fifthHorizontalRightVerticalSV: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .center
        return sv
    }()
    
    

    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(verticalSV)
        
        verticalSV.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor)
        verticalSV.addArrangedSubview(firstHorizontalView)
 
        firstHorizontalView.addArrangedSubview(firstHorizontalLeftVerticalSV)
        firstHorizontalLeftVerticalSV.addArrangedSubview(FirstSock)
        firstHorizontalLeftVerticalSV.addArrangedSubview(leftfirstPrice)
        firstHorizontalView.addArrangedSubview(firstHorizontalERighttVerticalSV)
        firstHorizontalERighttVerticalSV.addArrangedSubview(secondStock)
        firstHorizontalERighttVerticalSV.addArrangedSubview(rightStockPrice)
        
        verticalSV.addArrangedSubview(aboutTitle)
        
        
        verticalSV.addArrangedSubview(secondHorizontalVerticalSV)
        secondHorizontalVerticalSV.addArrangedSubview(secondtHorizontalLeftVerticalSV)
        secondtHorizontalLeftVerticalSV.addArrangedSubview(LeftBiolbl)
        secondHorizontalVerticalSV.addArrangedSubview(righttHorizontalLeftVerticalSV)
        righttHorizontalLeftVerticalSV.addArrangedSubview(rightBioLBl)
        
        verticalSV.addArrangedSubview(typeTitle)
        
        verticalSV.addArrangedSubview(thirdHorizontalView)
        thirdHorizontalView.addArrangedSubview(thirdtHorizontalLeftVerticalSV)
        thirdtHorizontalLeftVerticalSV.addArrangedSubview(leftTypeLBl)
        
        thirdHorizontalView.addArrangedSubview(thirdtHorizontalrightVerticalSV)
        thirdtHorizontalrightVerticalSV.addArrangedSubview(rightTypeLBl)
        
        //
        verticalSV.addArrangedSubview(marketCapLbl)
        verticalSV.addArrangedSubview(fouthHorizontalView)
        fouthHorizontalView.addArrangedSubview(fourthHorizontalLeftVerticalSV)
        fourthHorizontalLeftVerticalSV.addArrangedSubview(leftMarketCapLabl)
        fouthHorizontalView.addArrangedSubview(fourthHorizontalRightVerticalSV)
        fourthHorizontalRightVerticalSV.addArrangedSubview(rightMarketCapLabl)

        // adding the fifth stuff
        verticalSV.addArrangedSubview(volumeLbl)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
