//
//  FilterCollectionViewCell.swift
//  Stonx
//
//  Created by Angel Zambrano on 10/28/22.
//

import UIKit

class FilterCollectionViewCell: UICollectionViewCell {

    private var filtLabel: UILabel = UILabel()
    static let identifier = "FilterCollectionViewCell"
    
    override init(frame: CGRect) {
           super.init(frame: frame)
          
           
        
           filtLabel.translatesAutoresizingMaskIntoConstraints = false
           filtLabel.font = UIFont.systemFont(ofSize: 12)
           filtLabel.textColor = .black
           filtLabel.text = " "
           contentView.addSubview(filtLabel)
           
           contentView.backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1)
       
           
           //
           contentView.layer.cornerRadius = 12
           
           setUpConstraints()
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
       
       func setUpConstraints() {
           NSLayoutConstraint.activate([
               filtLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
               filtLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
           ])
       
       }
        
        // IGNORE: will fix later
       func configure(filter: Filter) {
         let greyCol  = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1)
           let blueCol = ColorConstants.green
         let blkCol:UIColor = .black
           let whiteCol: UIColor = .white
           
           contentView.backgroundColor = filter.isSelected() ? blueCol :greyCol
           filtLabel.text = filter.name
           filtLabel.textColor = filter.isSelected() ? whiteCol : blkCol
           
     
       }
       
       
       

}
