//
//  ContributionGraphView.swift
//  Github
//
//  Created by Sheikh Bayazid on 4/20/21.
//

import SwiftUI

struct ContributionGraphView: View {
    
    static let boxSize: CGFloat = 15
    static let spacing: CGFloat = 4
    
    private let rows = Array(
        repeating: GridItem(.fixed(boxSize), spacing: spacing),
        count: 7
    )
    
    let days: [DevelopmentDay]
    let selectedDay: (DevelopmentDay) -> Void
    
    func GitHubColor(for count: Int) -> Color {
        if count > 15 {
            return Color(red: 0.128, green: 0.428, blue: 0.222)
        } else if count > 10 {
            return Color(red: 0.192, green: 0.632, blue: 0.305)
        } else if count > 5 {
            return Color(red: 0.255, green: 0.768, blue: 0.391)
        } else if count > 0 {
            return Color(red: 0.606, green: 0.914, blue: 0.601)
        } else {
            return Color(.secondarySystemBackground)
        }
    }
    
    var body: some View {
        LazyHGrid(rows: rows, spacing: Self.spacing) {
            ForEach(days, id: \.date) { day in
                GitHubColor(for: day.dataCount)
                    .frame(width: Self.boxSize, height: Self.boxSize)
                    .border(Color(.tertiarySystemBackground), width: day.dataCount == 0 ? 1 : 0)
                    .cornerRadius(2)
                    .onTapGesture {
                        selectedDay(day)
                    }
            }
        }
    }
}

//struct ContributionGraphView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContributionGraphView(days: DevelopmentDay.example[0])
//    }
//}
