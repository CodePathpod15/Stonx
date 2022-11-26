//
//  Stats.swift
//  Stonx
//
//  Created by Angel Zambrano on 11/25/22.
//

import UIKit

class StatSV: UIStackView {
    private lazy var stockVolumeTextLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text = "1799234M"
        return textLabel
    }()
    
    lazy var imageIconVolume: UIButton = {
        let image = UIImage(systemName: "info.circle")?.withRenderingMode(.alwaysOriginal).withTintColor(ColorConstants.green)
        let button = UIButton(type: .system)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(indicatorWaspressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var stockVolumeHeaderLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text = "Volume"
        return textLabel
    }()
    
    private lazy var stockVolumeAndIconSV: UIStackView = {
        let hStackView = UIStackView()
        hStackView.translatesAutoresizingMaskIntoConstraints = false
        hStackView.axis = .horizontal
        hStackView.spacing = 2
        hStackView.alignment = .center
        hStackView.addArrangedSubview(imageIconVolume)
        hStackView.addArrangedSubview(stockVolumeHeaderLabel)

        return hStackView
    }()
    
    
    func configure(title:String) {
        self.stockVolumeHeaderLabel.text = title
    }
    
    func configure(amount: String) {
        self.stockVolumeTextLabel.text = amount
    }

    
    
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.distribution = .equalSpacing
        self.axis = .horizontal
        self.alignment = .leading
        self.addArrangedSubview(stockVolumeAndIconSV)
        self.addArrangedSubview(stockVolumeTextLabel)
        
    }
    
    @objc func indicatorWaspressed() {
      
        
    }
     
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
