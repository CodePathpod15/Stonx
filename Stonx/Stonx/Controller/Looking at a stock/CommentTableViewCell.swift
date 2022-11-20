//
//  CommentTableViewCell.swift
//  Stonx
//
//  Created by Angarag Gansukh on 11/14/22.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    static let identifier = "CommentCellID"
        
    private lazy var profImage = UIImage(systemName: "person.circle")
    
    private lazy var profImageView = UIImageView(image: profImage)
    
    private lazy var usernameLbl = UILabel()
    
    private lazy var commentLbl = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
        setLayouts()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpViews() {
        profImageView.translatesAutoresizingMaskIntoConstraints = false
        usernameLbl.translatesAutoresizingMaskIntoConstraints = false
        commentLbl.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(profImageView)
        contentView.addSubview(usernameLbl)
        contentView.addSubview(commentLbl)
        
        usernameLbl.font = FontConstants.boldFont
        profImageView.contentMode = .scaleAspectFill
        commentLbl.numberOfLines = 0
    }
    
    func configure(username: String, comment: String) {
        usernameLbl.text = username
        commentLbl.text = comment
    }
    
    private func setLayouts() {
        NSLayoutConstraint.activate([
            profImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            profImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        ])
        NSLayoutConstraint.activate([
            usernameLbl.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            usernameLbl.leadingAnchor.constraint(equalTo: profImageView.trailingAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            commentLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            commentLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            commentLbl.topAnchor.constraint(equalTo: profImageView.bottomAnchor, constant: 10),
            commentLbl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
        
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
