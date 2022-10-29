//
//  DarkModeTableViewCell.swift
//  Stonx
//
//  Created by Angel Zambrano on 10/29/22.
//

import UIKit

protocol DakrModeProtocol: AnyObject {
    func saveIsDark(isEnabled: Bool)
}

class DarkModeTableViewCell: UITableViewCell {

    static let identifier = "DarkModeTableViewCell"
    private let settingsSwitch:  UISwitch = {
        let settingsSwitch = UISwitch()
        settingsSwitch.addTarget(self, action: #selector(settingSwitchWasMoved), for: .touchUpInside)
        return settingsSwitch
    }()
    
    weak var delegate: DakrModeProtocol?
    
    private let lbl = UILabel()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
   
    }
    
    @objc func settingSwitchWasMoved() {
        delegate?.saveIsDark(isEnabled: settingsSwitch.isOn)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    func setProperty(isEnabled: Bool) {
        self.settingsSwitch.isOn = isEnabled
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // setting up views
        contentView.addSubview(lbl)
        lbl.text = "Turn the lights Off?"
        lbl.translatesAutoresizingMaskIntoConstraints = false

        lbl.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0).isActive = true
        
        lbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        
        
        contentView.addSubview(settingsSwitch)
        settingsSwitch.translatesAutoresizingMaskIntoConstraints = false
        
        settingsSwitch.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0).isActive = true
        
        settingsSwitch.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
