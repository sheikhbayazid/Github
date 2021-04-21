//
//  GithubStats.swift
//  GithubStats
//
//  Created by Sheikh Bayazid on 4/21/21.
//

import WidgetKit
import SwiftUI
import Intents

struct ContributionGraphEntry: TimelineEntry {
    let date: Date
    let day: [DevelopmentDay]
}

struct Dummy {
    static var dummyEntry: ContributionGraphEntry {
        let now = Date()
        let days = (0..<119).map { index -> DevelopmentDay in
            let date = Calendar.current.date(byAdding: .day, value: -index, to: now)!
            return DevelopmentDay(date: date, dataCount: 0)
        }
        return ContributionGraphEntry(date: now, day: days)
    }
}

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> ContributionGraphEntry {
        Dummy.dummyEntry
    }
    
    func getSnapshot(in context: Context, completion: @escaping (ContributionGraphEntry) -> Void) {
        completion(Dummy.dummyEntry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<ContributionGraphEntry>) -> Void) {
        GitHubParser.getDevelopmentDays(for: "sheikhbayazid") { day in
            let entry = ContributionGraphEntry(date: Date(), day: day)
            
            let timeline = Timeline(entries: [entry], policy: TimelineReloadPolicy.after(Calendar.current.date(byAdding: .day, value: 1, to: Date())!))
            completion(timeline)
        }
    }
    
}


struct GithubStatsEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        ContributionGraphView(days: entry.day) { _ in }
    }
}


@main
struct GithubStats: Widget {
    let kind = "GithubStats"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            GeometryReader { geo in
                ZStack {
                    GithubStatsEntryView(entry: entry)
                        .frame(width: geo.size.width, height: geo.size.height)
                        .overlay(RoundedRectangle(cornerRadius: 22).stroke(Color.green,lineWidth: 7.5))
                    
                    VStack {
                        HStack {
                            Text("sheikhbayazid")
                                .font(.footnote)
                                .foregroundColor(.secondary)
                                .padding()
                            Spacer()
                        }
                        Spacer()
                    }
                }
            }
        }.supportedFamilies([.systemMedium])
    }
}


struct GithubStats_Previews: PreviewProvider {
    static var previews: some View {
        
        GithubStatsEntryView(entry: Dummy.dummyEntry)
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
