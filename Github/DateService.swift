//
//  DateService.swift
//  Github
//
//  Created by Sheikh Bayazid on 4/20/21.
//

import Foundation

class DateService {
    private init() {}
    static let shared = DateService()
    
    var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
}
