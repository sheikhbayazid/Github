//
//  GithubParser.swift
//  Github
//
//  Created by Sheikh Bayazid on 4/20/21.
//

import Foundation
import SwiftSoup

enum GitHubParser {
    static func getDevelopmentDays(
        for username: String,
        completion: @escaping ([DevelopmentDay]) -> Void
    ) {
        do {
            let url = URL(string: "https://github.com/\(username)")!
            let html = try String(contentsOf: url)
            let doc = try SwiftSoup.parse(html)
            let dayElements = try doc.getElementsByClass("ContributionCalendar-day")
            
            let developmentDays = dayElements.compactMap { element -> DevelopmentDay? in
                print(element)
                guard
                    let dateString = try? element.attr("data-date"),
                    let date = DateService.shared.dateFormatter.date(from: dateString),
                    let dataCountString = try? element.attr("data-count"),
                    let dataCount = Int(dataCountString)
                else { return nil }
                
                
                return DevelopmentDay(date: date, dataCount: dataCount)
            }
            print(developmentDays)
            
            let thisSaturday = Calendar.current.nextDate(
                after: Date(),
                matching: DateComponents(weekday: 7),
                matchingPolicy: .nextTime
            )!
            
            let _17WeeksAgo = Calendar.current.date(
                byAdding: .weekOfMonth,
                value: -17,
                to: thisSaturday
            )!
            
            let last17Weeks = developmentDays.filter {
                $0.date > _17WeeksAgo
            }
            
            completion(last17Weeks)
            
        } catch {
            print(error)
        }
    }
}
