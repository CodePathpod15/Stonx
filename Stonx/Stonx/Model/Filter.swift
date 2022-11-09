//
//  Filter.swift
//  Stonx
//
//  Created by Angel Zambrano on 11/8/22.
//

import UIKit

// filter
class Filter {
    var name: String
    var selected: Bool = false
    
    init(name: String, selected: Bool) {
        self.name = name
        self.selected = selected
    }
    
    func isSelected() ->Bool {
        return selected
    }
}
