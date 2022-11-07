//
//  RecommendedStocks.swift
//  Stonx
//
//  Created by Angel Zambrano on 11/6/22.
//

import UIKit

protocol RecommendedStockDelegate: AnyObject {
    func userWantsToBuy()
}

class RecommendedStocks: UIView {
    //MARK: properties
    private let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    private let cContent = UIView()
    
    weak var delegate: RecommendedStockDelegate?
    
    private let doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = ColorConstants.green
        button.setTitle("Buy", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 6
        button.addTarget(self, action: #selector(buyButtonWasPressed), for: .touchUpInside)

        return button
    }()
    
    private var titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Today's Recommend Stock: \nXXXX"
        lbl.font = FontConstants.cellMediumFont
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    private var buttons = [UIButton]()
    
    private let horizontalSV: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
//        sv.backgroundColor = .red
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
        recommendedStock(with: 0)
    }
    

    private func changeTheColorOFAllButtons(till count: Int, lastElementIsHalf: Bool) {
        
        for i in 0..<count {
            let button = buttons[i]
            button.setImage(UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(ColorConstants.yellow), for: .normal)
        }
        
        if lastElementIsHalf {
            buttons[count-1].setImage(UIImage(systemName: "star.leadinghalf.filled")?.withRenderingMode(.alwaysOriginal).withTintColor(ColorConstants.yellow), for: .normal)
        }
        
    }
    
    //
    func configure(rating:Double, tickerName: String) {
        self.recommendedStock(with: rating)
        self.titleLbl.text = "Today's Recommend Stock: \n\(tickerName)"
        
        
    }
    
    private func recommendedStock(with stars: Double) {
        
        switch stars{
        case 1..<1.5:
            // fill the one star
            changeTheColorOFAllButtons(till: 1, lastElementIsHalf: false)
        break
            
        case 1.5..<2:
            changeTheColorOFAllButtons(till: 2, lastElementIsHalf: true)

        break
            
        case 2..<2.5:
            changeTheColorOFAllButtons(till: 2, lastElementIsHalf: false)
        break
            
        case 2.5..<3:
            changeTheColorOFAllButtons(till: 3, lastElementIsHalf: true)
        break
            
        case 3..<3.5:
            changeTheColorOFAllButtons(till: 3, lastElementIsHalf: false)
        break
            
        case 3.5..<4:
            changeTheColorOFAllButtons(till: 4, lastElementIsHalf: true)
        break
            
        case 4..<4.5:
            changeTheColorOFAllButtons(till: 4, lastElementIsHalf: false)
        break
            
        case 4.5..<5:
            changeTheColorOFAllButtons(till: 5, lastElementIsHalf: true)
        case 5:
            changeTheColorOFAllButtons(till: 5, lastElementIsHalf: false)
        break
        default:
            break
        }
  
    }
    
    
    
    
    private func createButtons(with color: UIColor) -> UIButton {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = false
        button.setImage(UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(color), for: .normal)
        return button
    }
    
    
    
    // deals with setting up layout
    private func setUpLayout() {
        self.addSubview(cContent)
//
        cContent.backgroundColor = .white
        cContent.translatesAutoresizingMaskIntoConstraints = false
        cContent.clipsToBounds = true
        cContent.layer.cornerRadius = 6
        
        cContent.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        cContent.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        cContent.widthAnchor.constraint(equalToConstant: 244).isActive = true
        cContent.heightAnchor.constraint(equalToConstant: 151).isActive = true
        
        cContent.addSubview(titleLbl)
        titleLbl.centerXAnchor.constraint(equalTo: cContent.centerXAnchor).isActive = true
        
        titleLbl.anchor(top: cContent.topAnchor, leading: cContent.leadingAnchor, bottom: nil, trailing: cContent.trailingAnchor, padding: .init(top: 15, left: 10, bottom: 0, right: 10))
        
        cContent.addSubview(horizontalSV)
        
        // setting up the buttons
        for _ in 0..<5{
            buttons.append(createButtons(with: .systemGray5))
        }
        
        // adding buttons to stackview
        for button in buttons {
            horizontalSV.addArrangedSubview(button)
        }
        
        horizontalSV.anchor(top: titleLbl.bottomAnchor, leading: titleLbl.leadingAnchor, bottom: nil, trailing: titleLbl.trailingAnchor,padding: .init(top: 15, left: 25, bottom: 0, right: 25),  size: .init(width: 0, height: 30))
        
        cContent.addSubview(doneButton)
        doneButton.anchor(top:horizontalSV.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 15, left: 0, bottom: 44, right: 0), size: .init(width: 150, height: 30))

        doneButton.centerXAnchor.constraint(equalTo: cContent.centerXAnchor).isActive = true
        
    }

    @objc func buyButtonWasPressed() {
        // number of stars
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
