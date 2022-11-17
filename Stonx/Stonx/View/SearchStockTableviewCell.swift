//
//  SearchStockTableviewCell.swift
//  Stonx
//
//  Created by Angel Zambrano on 10/28/22.
//

import UIKit



protocol ComparisonDelegate: AnyObject {
    func compareButtonWasPressed(with ticker: String)
}

// this is the tableview cell that contains no chart, primarly used for searchign
class SearchStockTableviewCell: UITableViewCell {
    
    // MARK: properties
    
    static let identifier = "SearchStockTableviewCell"
    private let stockLbl = UILabel()
    private let stockFullName = UILabel()
         
    private let hStackView: UIStackView = {
        let hv = UIStackView(frame: .zero)
        hv.translatesAutoresizingMaskIntoConstraints = false
        hv.distribution = .fill
        
        hv.axis = .horizontal
        hv.spacing = 0
        return hv
    }()
    
    weak var delegate: ComparisonDelegate?
    
    private let vStackview: UIStackView = {
        let sv = UIStackView(frame: .zero)
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.alignment = .leading
        return sv
    }()
    
    private let rightvStackView: UIStackView = {
        let sv = UIStackView(frame: .zero)
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        return sv
    }()
    
     let compareButton: UIButton = {
        let btn  = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "arrow.left.arrow.right")?.withRenderingMode(.alwaysOriginal).withTintColor(ColorConstants.green), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(SearchStocksViewController.compareBTN), for: .touchUpInside)
        return btn
    }()
    
    var isEnabledTewou: Bool = false
    
     override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)
         print(isEnabledTewou)
         setUPViews()
         setUpConstraints()
         
     }
    
    func addingRightButton() {
        
    }
    
    func enableCompareButton(with enabled: Bool) {
        if enabled {
            NSLayoutConstraint.activate([
               vStackview.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
               vStackview.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
            ])
            compareButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
            compareButton.anchor(top: nil, leading: nil, bottom: nil, trailing: contentView.trailingAnchor,padding: .init(top: 0, left: 0, bottom: 0, right: 16), size: .init(width: 20, height: 20))
            
            contentView.bringSubviewToFront(compareButton)
            
            // setting up the constrains of right stackview
            NSLayoutConstraint.activate([
               
               rightvStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
               rightvStackView.trailingAnchor.constraint(equalTo: compareButton.leadingAnchor, constant: -16),
               rightvStackView.widthAnchor.constraint(equalToConstant: 150)
            ])
        } else {
            compareButton.removeFromSuperview()
            NSLayoutConstraint.activate([
               vStackview.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
               vStackview.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
            ])
            // setting up the constrains of right stackview
            NSLayoutConstraint.activate([
               
               rightvStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
               rightvStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
               rightvStackView.widthAnchor.constraint(equalToConstant: 150)
            ])
        }
    }
    
    @objc func compareBtnWasPressed() {
        delegate?.compareButtonWasPressed(with: stockLbl.text!)
    }
     
     private func setUPViews() {
         contentView.addSubview(vStackview)
         
         vStackview.addArrangedSubview(hStackView)

         hStackView.addArrangedSubview(stockLbl)
         
         stockLbl.text = "APPL"
         stockLbl.font = FontConstants.boldFont
         stockLbl.translatesAutoresizingMaskIntoConstraints = false
         
         contentView.addSubview(rightvStackView)
         
         rightvStackView.addArrangedSubview(stockFullName)
         stockFullName.translatesAutoresizingMaskIntoConstraints = false
         stockFullName.font = FontConstants.regularFont
         stockFullName.textAlignment = .center
         stockFullName.numberOfLines = 2
         stockFullName.text = "155.74"
         

         contentView.addSubview(compareButton)
         
     }
    
    //configuring the cell
    // this is configuirng the sell when we're searching for a stock
     func configure(ticker: String = "Error", fullName: String? = "Error", market: String? = "error") {
        self.stockLbl.text = ticker

         self.stockFullName.text = fullName

    }

    /// in charge of constraints
     private func setUpConstraints() {
         // setting up the constrains of left stackview
     
         
     }

     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
    

}
