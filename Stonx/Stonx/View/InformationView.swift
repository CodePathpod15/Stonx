//
//  InformationView.swift
//  Stonx
//
//  Created by Angel Zambrano on 11/8/22.
//

import UIKit

// this is displayed whenever the user presses the information vie w
class InformationView: UIView {
    
    //MARK: properties
    private let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    private let cContent = UIView()
    
    weak var delegate: RecommendedStockDelegate?
    
    private let doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = ColorConstants.green
        button.setTitle("Okay", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 6
        button.addTarget(self, action: #selector(buyButtonWasPressed), for: .touchUpInside)

        return button
    }()
    
    private var titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Market Cap"
        lbl.font = FontConstants.boldLargeFont
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    private let horizontalSV: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.distribution = .equalSpacing
        return sv
    }()

    
    
    // MARK: initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBlurView()
        setUpLayout()
        self.layer.cornerRadius = 6
        self.clipsToBounds = true
        self.layer.masksToBounds = true
    }
    
    
    let descriptionLbl:UILabel = {
        let lbl = UILabel()
        lbl.text = "Refers to how much a company is worth as determined by the stock market. It is defined as the total market value of all outstanding shares."
        lbl.numberOfLines = 0
        lbl.font = FontConstants.cellMediumFont
        lbl.textAlignment = .center
        return lbl
    }()
    
    // this configures the cell
    func configure(title: String, caption: String) {
        self.titleLbl.text = title
        self.descriptionLbl.text = caption
    }

    // deals with setting up layout
    private func setUpLayout() {
        self.addSubview(cContent)
        cContent.backgroundColor = .white
        cContent.translatesAutoresizingMaskIntoConstraints = false
        cContent.clipsToBounds = true
        cContent.layer.cornerRadius = 6
        
        cContent.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        cContent.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        cContent.widthAnchor.constraint(equalToConstant: 244).isActive = true
        
        cContent.addSubview(titleLbl)
        titleLbl.centerXAnchor.constraint(equalTo: cContent.centerXAnchor).isActive = true
        
        titleLbl.anchor(top: cContent.topAnchor, leading: cContent.leadingAnchor, bottom: nil, trailing: cContent.trailingAnchor, padding: .init(top: 15, left: 10, bottom: 0, right: 10))
        
        cContent.addSubview(horizontalSV)
        
        horizontalSV.addArrangedSubview(descriptionLbl)
     
        
        horizontalSV.anchor(top: titleLbl.bottomAnchor, leading: titleLbl.leadingAnchor, bottom: nil, trailing: titleLbl.trailingAnchor,padding: .init(top: 15, left: 25, bottom: 0, right: 25))

        cContent.addSubview(doneButton)
        doneButton.anchor(top:horizontalSV.bottomAnchor, leading: nil, bottom: cContent.bottomAnchor, trailing: nil, padding: .init(top: 15, left: 0, bottom: 15, right: 0), size: .init(width: 150, height: 30))

        doneButton.centerXAnchor.constraint(equalTo: cContent.centerXAnchor).isActive = true
        
    }

    
    @objc func buyButtonWasPressed() {
        delegate?.userWantsToBuy()
        handleDimiss()
    }
    
    
    func handleDimiss() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut) {
            self.alpha = 0
        } completion: { _ in
            // we remove the view from the superview
            self.removeFromSuperview()
        }
    }
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
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

    @objc fileprivate func handleTapDimiss() {
 
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut) {
            self.alpha = 0
        } completion: { _ in
            // we remove the view from the superview
            self.removeFromSuperview()
        }
    }
}
