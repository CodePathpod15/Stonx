//
//  RateTheStock.swift
//  Stonx
//
//  Created by Angel Zambrano on 11/6/22.
//

import UIKit



protocol RateDelegate: AnyObject {
    func rate(number: Int)
}


class RateTheStock: UIView {
    //MARK: properties
    let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    let cContent = UIView()
    
    let doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = ColorConstants.green
        button.setTitle("Rate", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 6
        button.addTarget(self, action: #selector(rateButtonwasPressed), for: .touchUpInside)

        return button
    }()
    
    var titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Please rate your experience with XXXX"
        lbl.font = FontConstants.cellMediumFont
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    var buttons = [UIButton]()
    
    let horizontalSV: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
//        sv.backgroundColor = .red
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.distribution = .equalSpacing
        return sv
    }()
    
    weak var delegate: RateDelegate?
    
    
    
    // MARK: initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBlurView()
        setUpLayout()
        self.layer.cornerRadius = 6
        self.clipsToBounds = true
        self.layer.masksToBounds = true
    }
    
    
    func createButtons(with color: UIColor) -> UIButton {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(starWasPressed), for: .touchUpInside)
        button.setImage(UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(color), for: .normal)
        return button
    }
    
    var numberOfStars = 1
    
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
        for n in 0..<5{
            if n == 0 {
                buttons.append(createButtons(with: UIColor(red: 245/255, green: 191/255, blue: 65/255, alpha: 1)))
                continue
            }
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

    @objc func rateButtonwasPressed() {
        // number of stars
        delegate?.rate(number: numberOfStars)
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
    
    
    
    @objc func starWasPressed(button: UIButton) {

        let index = buttons.firstIndex{$0 === button} as? Int
        
        numberOfStars = index! + 1
        
        if let index = index {
            // updating the stars to yellow
            for i in 0..<(index + 1) {
                buttons[i].setImage(UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(ColorConstants.yellow), for: .normal)
            }
            
            // updating the stars to
            let newIndex = (index + 1)
            for i in newIndex..<buttons.count {
                buttons[i].setImage(UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor.systemGray5), for: .normal)
            }
            
        }

        
        
    }
    
    
    
    
    func createLayout() {
        
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
