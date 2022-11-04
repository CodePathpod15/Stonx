//
//  TransactionSuccessfulViewController.swift
//  Stonx
//
//  Created by Angel Zambrano on 11/2/22.
//

import UIKit
import Lottie



class TransactionSuccessfulViewController: UIViewController {

    // MARK: properties
    
    var animationView: AnimationView?

    
   private let whiteVIew = UIView()
    private let label: UILabel = {
       let titleLbl = UILabel()
        titleLbl.text = "APPL Purchased"
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        titleLbl.textColor = .white
        titleLbl.font = FontConstants.boldFont
        return titleLbl
    }()
    
    private  let numberOfSharesBoughtLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "1"
        lbl.textAlignment = .center
        lbl.font = FontConstants.regularFont
        return lbl
    }()
    
    private let numberOfSharesBoughtTitle: UILabel = {
        let lbl = UILabel()
        lbl.text = "Shares bought"
        lbl.font = FontConstants.regularFont
        lbl.textColor = .gray
        lbl.textAlignment = .center
        return lbl
    }()
    
    
    // credit left
    private let creditLeft: UILabel = {
        let lbl = UILabel()
        lbl.text = "Total Credit"
        lbl.textAlignment = .center
        lbl.font = FontConstants.regularFont
        lbl.textColor = .gray
        return lbl
    }()
    
    private let creditLeftTitle: UILabel = {
        let lbl = UILabel()
        lbl.text = "$3.00"
        lbl.textAlignment = .center
        return lbl
    }()
    
    private let creditVerticalSV: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        return sv
    }()
    
    let vsharesStackview: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        return sv
    }()
    
    let hSV: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 25 // or 35
        return sv
    }()
    
    
    // the set up for the new position
    private let newPositionTitle: UILabel = {
        let lbl = UILabel()
        lbl.text = "New Positon"
        lbl.textColor = .gray
        lbl.font = FontConstants.regularFont
        return lbl
    }()
    
    //
    private let newPositionNumber: UILabel = {
        let lbl = UILabel()
        lbl.text = "0 Shares"
        lbl.font = FontConstants.regularFont
        return lbl
    }()
    
    let positionHStack: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        return sv
    }()
    
    // the set up for the price per share
    let priceperShareTitle: UILabel = {
        let lbl = UILabel()
        lbl.text = "price Per Share"
        lbl.textColor = .gray
        lbl.font = FontConstants.regularFont
        return lbl

    }()
    
    // set the price per share
    let priceperShare: UILabel = {
            let lbl = UILabel()
            lbl.text = "0 Shares"
        lbl.font = FontConstants.regularFont
            return lbl
    }()
    
    let pricePerShareSV: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .fill

        return sv
    }()
    
    // vertical stack for price per share and position
    let verticalSVForPricePerShareAndPosition: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 6
        return sv
    }()
    
    let button: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Done", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = ColorConstants.green
        btn.addTarget(self, action: #selector(buttonWasPressed), for: .touchUpInside)
        btn.layer.cornerRadius = 16
        return btn
    }()
  
    
    @objc func buttonWasPressed() {
        self.dismiss(animated: true, completion: nil)
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
       
        animationView = .init(name: "90469-confetti")
        
        

        view.addSubview(animationView!)
       
        view.backgroundColor = ColorConstants.green
        viewSetUp()
        setUpContraints()
        
        animationView?.translatesAutoresizingMaskIntoConstraints = false
        animationView?.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        animationView?.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        animationView?.widthAnchor.constraint(equalToConstant: 1000).isActive = true
        animationView?.heightAnchor.constraint(equalToConstant: 1000).isActive = true
        

        
       
        animationView?.contentMode = .scaleAspectFit
        animationView?.animationSpeed = 1.5
        
        animationView?.play()

    }
    
    

    
    private func viewSetUp() {
        view.addSubview(label)
        
        
        
        whiteVIew.backgroundColor = .white
        whiteVIew.layer.cornerRadius = 8
        view.addSubview(whiteVIew)
        
        vsharesStackview.addArrangedSubview(numberOfSharesBoughtLbl)
        vsharesStackview.addArrangedSubview(numberOfSharesBoughtTitle)
        creditVerticalSV.addArrangedSubview(creditLeftTitle)
        creditVerticalSV.addArrangedSubview(creditLeft)
       

        whiteVIew.addSubview(hSV)
        hSV.addArrangedSubview(vsharesStackview)
        hSV.addArrangedSubview(creditVerticalSV)
        hSV.translatesAutoresizingMaskIntoConstraints = false
        
        whiteVIew.addSubview(verticalSVForPricePerShareAndPosition)
        verticalSVForPricePerShareAndPosition.translatesAutoresizingMaskIntoConstraints = false
        
        // adding the horizontal position stackview
        positionHStack.translatesAutoresizingMaskIntoConstraints = false
        positionHStack.addArrangedSubview(newPositionTitle)
        positionHStack.addArrangedSubview(newPositionNumber)
        verticalSVForPricePerShareAndPosition.addArrangedSubview(positionHStack)

        
        pricePerShareSV.translatesAutoresizingMaskIntoConstraints = false
        pricePerShareSV.addArrangedSubview(priceperShareTitle)
        pricePerShareSV.addArrangedSubview(priceperShare)
        verticalSVForPricePerShareAndPosition.addArrangedSubview(pricePerShareSV)
        
        whiteVIew.addSubview(button)
       
        
    }
    
    
    private func setUpContraints() {
        
        
        // setting up the white view
        whiteVIew.anchor(top: label.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 17, left: 0, bottom: 0, right: 0) ,size: .init(width: 259, height: 314))
 
        whiteVIew.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        whiteVIew.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        label.centerXAnchor.constraint(equalTo: whiteVIew.centerXAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: whiteVIew.topAnchor, constant: -16).isActive = true

        
        hSV.centerXAnchor.constraint(equalTo: whiteVIew.centerXAnchor).isActive = true
        hSV.topAnchor.constraint(equalTo: whiteVIew.topAnchor, constant: 50).isActive = true
        
        // 31
        NSLayoutConstraint.activate([
            verticalSVForPricePerShareAndPosition.leadingAnchor.constraint(equalTo: whiteVIew.leadingAnchor, constant: 10),
            verticalSVForPricePerShareAndPosition.trailingAnchor.constraint(equalTo: whiteVIew.trailingAnchor, constant: -10),
            verticalSVForPricePerShareAndPosition.topAnchor.constraint(equalTo: hSV.bottomAnchor, constant: 35)
            
        ])
    
       

        
        button.anchor(top:verticalSVForPricePerShareAndPosition.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 35, left: 0, bottom: 44, right: 0), size: .init(width: 150, height: 30))
        
        
        
        button.centerXAnchor.constraint(equalTo: whiteVIew.centerXAnchor).isActive = true

    }


}
