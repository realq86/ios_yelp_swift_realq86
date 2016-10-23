//
//  CurrentFilters.swift
//  
//
//  Created by Developer on 10/23/16.
//
//

import UIKit

enum FilterSortBy: Int{
    case none = -1
    case bastMatch = 0
    case distance = 1
    case highestRated = 2
}

enum FilterDistanceBy: Int{
    case none = -1
    case close = 0
    case near = 1
    case local = 2
    case far = 3
}


class CurrentFilters: NSObject {
    
    var filterDeal = [""]
    var filterDistance:FilterDistanceBy? = FilterDistanceBy.close
    var filterSort:FilterSortBy? = FilterSortBy.bastMatch
    var categories = [""]
    
    override init() {
        
        super.init()
    }

}
