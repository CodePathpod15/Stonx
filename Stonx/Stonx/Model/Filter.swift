//
//  Filter.swift
//  Stonx
//
//  Created by Angel Zambrano on 11/8/22.
//

import UIKit

// filter
class Filter: Equatable {
    
    
    var name: String
    var selected: Bool = false
    
    init(name: String, selected: Bool) {
        self.name = name
        self.selected = selected
    }
    
    func isSelected() ->Bool {
        return selected
    }
    
    static func == (lhs: Filter, rhs: Filter) -> Bool {
        return lhs.name == rhs.name
    }
}
