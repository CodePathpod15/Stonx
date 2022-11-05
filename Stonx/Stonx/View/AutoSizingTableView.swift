//
//  AutoSizingTableView.swift
//  Meusic
//
//  Created by Angel Zambrano on 3/23/22.
//

import Foundation
import UIKit

// Credits: https://stackoverflow.com/questions/61521752/how-to-create-an-uitableview-with-an-intrinsic-height-in-swift-5-using-uikit
final class AutoSizingTableView: UITableView {

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setContentCompressionResistancePriority(.required, for: .vertical)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setContentCompressionResistancePriority(.required, for: .vertical)
    }

    override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    override func reloadData() {
        super.reloadData()
        invalidateIntrinsicContentSize()
    }

    override var intrinsicContentSize: CGSize {
        setNeedsLayout()
        layoutIfNeeded()
        return contentSize
    }
}
