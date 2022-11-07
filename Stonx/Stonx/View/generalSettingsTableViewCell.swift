//
//  generalSettingsTableViewCell.swift
//  Stonx
//
//  Created by Angel Zambrano on 11/1/22.
//

import UIKit

// general settings tableviewCell

class generalSettingsTableViewCell: UITableViewCell {

    static let identifier = "generalSettingsTableViewCell"
    private let title = UILabel()

    
  
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpViews()
        setUpConstraints()
    }
    
    private func setUpViews() {
        contentView.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
    }
   
    // configures the cell
    func configure(with text: String) {
        self.title.text = text
    }

    func setUpConstraints() {
        title.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
    }

    // ignore this
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
