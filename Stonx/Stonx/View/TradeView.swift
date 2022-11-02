//
//  TradeView.swift
//  Stonx
//
//  Created by Angel Zambrano on 11/1/22.
//

import UIKit

// this view contains the view that asks the user if they want to buy or sell
class TradeView: UIView {

    //MARK: properties
    let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    let cContent = UIView()
    
   private let buyButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = ColorConstants.green
        button.setTitle("Buy", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
       button.layer.cornerRadius = 6
        return button
    }()
    
    private let sellButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = ColorConstants.red
        button.setTitle("Sell", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 6
        return button
    }()
    
    private let orLbl = UILabel()
    
    

    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBlurView()
        setUpLayout()
        self.layer.cornerRadius = 6
        self.clipsToBounds = true
        self.layer.masksToBounds = true
        
    }
    
    
    // adds blue to the background
    fileprivate func setupBlurView() {
       
        visualEffectView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapDimiss)))
        
        addSubview(visualEffectView)
        visualEffectView.fillSuperview()
        visualEffectView.alpha = 0
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut) {
            self.visualEffectView.alpha = 1
        } completion: { _ in
            
        }

        
    }
    
    /// deals with the tapping gesture
    @objc fileprivate func handleTapDimiss() {
 
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut) {
            self.alpha = 0
        } completion: { _ in
            // we remove the view from the superview
            self.removeFromSuperview()
        }
    }
    
    
   
    // deals with setting up layout
    private func setUpLayout() {
        self.addSubview(cContent)
        cContent.backgroundColor = .white
        cContent.translatesAutoresizingMaskIntoConstraints = false
        
        cContent.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        cContent.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        cContent.widthAnchor.constraint(equalToConstant: 244).isActive = true
        cContent.heightAnchor.constraint(equalToConstant: 151).isActive = true
        
        
        orLbl.translatesAutoresizingMaskIntoConstraints = false
        cContent.addSubview(sellButton)
        cContent.addSubview(buyButton)
        cContent.addSubview(orLbl)
        orLbl.text = "or"
        

        
        orLbl.centerXAnchor.constraint(equalTo: cContent.centerXAnchor).isActive = true
        orLbl.centerYAnchor.constraint(equalTo: cContent.centerYAnchor).isActive = true

        
        buyButton.centerXAnchor.constraint(equalTo: cContent.centerXAnchor).isActive = true
        buyButton.bottomAnchor.constraint(equalTo: orLbl.topAnchor, constant: -3).isActive = true
        buyButton.leadingAnchor.constraint(equalTo: cContent.leadingAnchor, constant: 32).isActive = true
        buyButton.trailingAnchor.constraint(equalTo: cContent.trailingAnchor, constant: -32).isActive = true

        
        sellButton.centerXAnchor.constraint(equalTo: cContent.centerXAnchor).isActive = true
        sellButton.topAnchor.constraint(equalTo: orLbl.bottomAnchor, constant: 3).isActive = true
        sellButton.leadingAnchor.constraint(equalTo: cContent.leadingAnchor, constant: 32).isActive = true
        sellButton.trailingAnchor.constraint(equalTo: cContent.trailingAnchor, constant: -32).isActive = true

        
        
        
//        cContent.centerXAnchor.constraint(equalTo: orLbl.bottomAnchor, constant: 3).isActive = true
//        cContent.leadingAnchor.constraint(equalTo: cContent.leadingAnchor, constant: 32).isActive = true
        
        
        
        
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
