//
//  BalanceTableViewCell.swift
//  Stonx
//
//  Created by Angel Zambrano on 10/29/22.
//

import UIKit

class BalanceTableViewCell: UITableViewCell {

    static let identifier = "BalanceTableViewCell"
    
    private let titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        return lbl
    }()
    
    private let amountLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "$2000"
        lbl.textColor = .systemGray
        return lbl
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
     
        setUpView()
        setUpContraints()
    }
    
    func configure(name: String) {
        self.amountLbl.text = name
    }
   private func setUpView() {
       contentView.addSubview(titleLbl)
       titleLbl.translatesAutoresizingMaskIntoConstraints = false
       
       contentView.addSubview(amountLbl)
       amountLbl.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setUpContraints() {
        // setting constraints for title
        var inset = separatorInset.left * 2 + 4
        
        if UIDevice().userInterfaceIdiom == .phone {
               switch UIScreen.main.nativeBounds.height {
               case 2436:
                   inset = 16
                   break

               default:
                   print("UNDETERMINED")
               }
            
        }
        
        titleLbl.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        titleLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        amountLbl.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        amountLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
    
        }
    
    func configure(with title: String) {
        self.titleLbl.text = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
