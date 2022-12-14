//
//  VerticalSV.swift
//  Stonx
//
//  Created by Angel Zambrano on 11/9/22.
//

import UIKit

// this is the stackview that contains all of the views for the comparisonview 
class VerticalSV: UIStackView {
    
  private  let firstHorizontalView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.distribution = .fillEqually
        return sv
    }()
    
    private  let firstHorizontalLeftVerticalSV: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .center
        return sv
    }()
    
    private let FirstSock: UILabel = {
        let lbl = UILabel()
        lbl.font = FontConstants.boldLargeFont
        return lbl
    }()
    
    private let leftfirstPrice: UILabel = {
        let lbl = UILabel()
        lbl.text = "4070.00"
        lbl.font = FontConstants.cellMediumFont
        lbl.textColor = ColorConstants.green
        lbl.font = FontConstants.boldLargeFont
        return lbl
    }()
    
    private let firstHorizontalERighttVerticalSV: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .center
        return sv
    }()
    
    private  let secondStock: UILabel = {
        let lbl = UILabel()
        lbl.font = FontConstants.boldLargeFont
        return lbl
    }()
 
    private let rightStockPrice: UILabel = {
        let lbl = UILabel()
        lbl.text = "4070.00"
        lbl.font = FontConstants.boldLargeFont
        lbl.textColor = ColorConstants.green
        return lbl
    }()
    
    private let aboutTitle: UILabel = {
        let lbl = UILabel()
        lbl.text = "About"
        lbl.font = FontConstants.boldLargeFont
        lbl.textAlignment = .center
        return lbl
    }()
    
    // this is the 2nd horitzontal SV
    // contains the about me portion
    private let secondHorizontalVerticalSV: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.distribution = .fillEqually
        return sv
    }()
    
    private let secondtHorizontalLeftVerticalSV: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .center
        return sv
    }()
    
    
    private let LeftBiolbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.darkGray

        lbl.numberOfLines = 9
        lbl.textAlignment = .left
        return lbl
    }()
    
    private let rightBioLBl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.darkGray
        lbl.numberOfLines = 9
        lbl.textAlignment = .left
        return lbl
    }()
    
    private let righttHorizontalLeftVerticalSV: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .center
        return sv
    }()
    
    private let typeTitle: UILabel = {
        let lbl = UILabel()
        lbl.text = "Type"
        lbl.font = FontConstants.boldLargeFont
        lbl.textAlignment = .center
        return lbl
    }()
    
    // the type of the viewcontroller
    
    private let thirdHorizontalView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.distribution = .fillEqually
        return sv
    }()
    
    
    private let thirdtHorizontalLeftVerticalSV: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .center
        return sv
    }()
    
    private let leftTypeLBl: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 1
        lbl.textAlignment = .center
        lbl.textColor = UIColor.darkGray

        return lbl
    }()
    
    private let rightTypeLBl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.darkGray
        lbl.numberOfLines = 1
        lbl.textAlignment = .center
        return lbl
    }()
    
    
    private let thirdtHorizontalrightVerticalSV: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .center
        return sv
    }()
    
    // the markets stats
    private let marketCapLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Market Cap"
        lbl.font = FontConstants.boldLargeFont
        lbl.textAlignment = .center
        return lbl
    }()
    
    
    private let fouthHorizontalView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.distribution = .fillEqually
        return sv
    }()
    
    private let leftMarketCapLabl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.darkGray
        lbl.numberOfLines = 1
        lbl.textAlignment = .center
        return lbl
    }()
    
    private let fourthHorizontalLeftVerticalSV: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .center
        return sv
    }()
    
    private let rightMarketCapLabl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.darkGray
        lbl.numberOfLines = 1
        lbl.textAlignment = .center
        return lbl
    }()
    
    private let fourthHorizontalRightVerticalSV: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .center
        return sv
    }()
    
  
    
    private let fifthHorizontalView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.distribution = .fillEqually
        return sv
    }()
    
  
    
    private let fifthHorizontalLeftVerticalSV: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .center
        return sv
    }()
    
 
    
    private let fifthHorizontalRightVerticalSV: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .center
        return sv
    }()
    
    // P/E ration
    private let PERatio: UILabel = {
        let lbl = UILabel()
        lbl.text = "P/E Ratio"
        lbl.font = FontConstants.boldLargeFont
        lbl.textAlignment = .center
        return lbl
    }()
    
    private let sixthHorizontalView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.distribution = .fillEqually
        return sv
    }()
    
    private let leftPERatioLabl: UILabel = {
        let lbl = UILabel()

        lbl.textColor = UIColor.darkGray
        lbl.numberOfLines = 1
        lbl.textAlignment = .center
        return lbl
    }()
    
    private let sixthHorizontalLeftVerticalSV: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .center
        return sv
    }()
    
    private let rightPERatioLabl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.darkGray
        lbl.numberOfLines = 1
        lbl.textAlignment = .center
        return lbl
    }()
    
    private let sixthHorizontalRightVerticalSV: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .center
        return sv
    }()
    
    // adding the EPS
    private let EPSRatioLBL: UILabel = {
        let lbl = UILabel()
        lbl.text = "EPS"
        lbl.font = FontConstants.boldLargeFont
        lbl.textAlignment = .center
        return lbl
    }()
    
    private let seventhHorizontalView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.distribution = .fillEqually
        return sv
    }()
    
    private let leftPEPSLabl: UILabel = {
        let lbl = UILabel()

        lbl.textColor = UIColor.darkGray
        lbl.numberOfLines = 1
        lbl.textAlignment = .center
        return lbl
    }()
    
    private let seventhHorizontalLeftVerticalSV: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .center
        return sv
    }()
    
    private let rightEPSLabl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.darkGray
        lbl.numberOfLines = 1
        lbl.textAlignment = .center
        return lbl
    }()
    
    private let seventhHorizontalRightVerticalSV: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .center
        return sv
    }()
    
    func editLeft(price: Double, and volume: String) {
        self.leftfirstPrice.text = String(price)
        
    }

    func editLeftSide(
        tickerName: String?,
        about: String?,
        type: String?,
        marketCap: String?,
        PERatio: String?,
        EPS: String?) {
            
        // this is initially given
        if let tickerName = tickerName {
            FirstSock.text = tickerName
        }
       
        if let about = about, let type = type, let marketCap = marketCap, let PERatio = PERatio, let EPS = EPS  {
            self.LeftBiolbl.text = about
            self.leftTypeLBl.text = type
            self.leftMarketCapLabl.text = marketCap

            self.leftPERatioLabl.text = PERatio
            self.leftPEPSLabl.text = EPS
        }
    
    }
    
    // editing the EPS
    func editRightSide(
        tickerName: String? ,
        about: String? ,
        type: String? ,
        marketCap: String? ,
        PERatio: String? ,
        EPS: String?) {
        
        // this is initially given
        if let tickerName = tickerName {
            secondStock.text = tickerName
        }
            
        if let about = about, let type = type, let marketCap = marketCap, let PERatio = PERatio, let EPS = EPS  {
           
           self.rightBioLBl.text = about
           self.rightTypeLBl.text = type
           self.rightMarketCapLabl.text = marketCap
           self.rightPERatioLabl.text = PERatio
           self.rightEPSLabl.text = EPS
        }

      
    }
    
    func editRight(price: Double, volume: String) {
        self.rightStockPrice.text = String(price)
        
    }
    
    override init(frame:CGRect) {
           super.init(frame: frame)
        
        self.addArrangedSubview(firstHorizontalView)
 
        firstHorizontalView.addArrangedSubview(firstHorizontalLeftVerticalSV)
        firstHorizontalLeftVerticalSV.addArrangedSubview(FirstSock)
        firstHorizontalLeftVerticalSV.addArrangedSubview(leftfirstPrice)
        firstHorizontalView.addArrangedSubview(firstHorizontalERighttVerticalSV)
        firstHorizontalERighttVerticalSV.addArrangedSubview(secondStock)
        firstHorizontalERighttVerticalSV.addArrangedSubview(rightStockPrice)
        
        self.addArrangedSubview(aboutTitle)
        
        
        self.addArrangedSubview(secondHorizontalVerticalSV)
        secondHorizontalVerticalSV.addArrangedSubview(secondtHorizontalLeftVerticalSV)
        secondtHorizontalLeftVerticalSV.addArrangedSubview(LeftBiolbl)
        secondHorizontalVerticalSV.addArrangedSubview(righttHorizontalLeftVerticalSV)
        righttHorizontalLeftVerticalSV.addArrangedSubview(rightBioLBl)
        
        self.addArrangedSubview(typeTitle)
        
        self.addArrangedSubview(thirdHorizontalView)
        thirdHorizontalView.addArrangedSubview(thirdtHorizontalLeftVerticalSV)
        thirdtHorizontalLeftVerticalSV.addArrangedSubview(leftTypeLBl)
        
        thirdHorizontalView.addArrangedSubview(thirdtHorizontalrightVerticalSV)
        thirdtHorizontalrightVerticalSV.addArrangedSubview(rightTypeLBl)
        
        //
        self.addArrangedSubview(marketCapLbl)
        self.addArrangedSubview(fouthHorizontalView)
        fouthHorizontalView.addArrangedSubview(fourthHorizontalLeftVerticalSV)
        fourthHorizontalLeftVerticalSV.addArrangedSubview(leftMarketCapLabl)
        fouthHorizontalView.addArrangedSubview(fourthHorizontalRightVerticalSV)
        fourthHorizontalRightVerticalSV.addArrangedSubview(rightMarketCapLabl)

        // adding the fifth stuff
   
        self.addArrangedSubview(fifthHorizontalView)
        fifthHorizontalView.addArrangedSubview(fifthHorizontalLeftVerticalSV)
        
        fifthHorizontalView.addArrangedSubview(fifthHorizontalRightVerticalSV)
        
        
        self.addArrangedSubview(PERatio)
        self.addArrangedSubview(sixthHorizontalView)
        sixthHorizontalView.addArrangedSubview(sixthHorizontalLeftVerticalSV)
        sixthHorizontalLeftVerticalSV.addArrangedSubview(leftPERatioLabl)
        sixthHorizontalView.addArrangedSubview(sixthHorizontalRightVerticalSV)
        sixthHorizontalRightVerticalSV.addArrangedSubview(rightPERatioLabl)
        
        // adding the sixth view
        self.addArrangedSubview(EPSRatioLBL)
        self.addArrangedSubview(seventhHorizontalView)
        seventhHorizontalView.addArrangedSubview(seventhHorizontalLeftVerticalSV)
        seventhHorizontalLeftVerticalSV.addArrangedSubview(leftPEPSLabl)
        seventhHorizontalView.addArrangedSubview(seventhHorizontalRightVerticalSV)
        seventhHorizontalRightVerticalSV.addArrangedSubview(rightEPSLabl)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

