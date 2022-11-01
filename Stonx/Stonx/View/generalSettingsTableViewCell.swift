//
//  generalSettingsTableViewCell.swift
//  Stonx
//
//  Created by Angel Zambrano on 11/1/22.
//

import UIKit

class generalSettingsTableViewCell: UITableViewCell {
    
    static let identifier = "generalSettingsTableViewCell"
    private let title = UILabel()

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization codex
    }
    
  
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
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}