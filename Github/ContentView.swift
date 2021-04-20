//
//  ContentView.swift
//  Github
//
//  Created by Sheikh Bayazid on 4/20/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    var body: some View {
        VStack {
            ContributionGraphView(
                days: viewModel.days,
                selectedDay: { viewModel.selectedDay = $0 }
            ).frame(width: UIScreen.main.bounds.size.width - 50, height: 150, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.green,lineWidth: 1))
            
            if let selectedDay = viewModel.selectedDay {
                Text("You made \(selectedDay.dataCount) contribution(s) on \(DateService.shared.dateFormatter.string(from: selectedDay.date))")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



extension ContentView {
    class ViewModel: ObservableObject {
        @Published var days = [DevelopmentDay]()
        @Published var selectedDay: DevelopmentDay?
        
        init() {
            getDevelopmentDays()
        }
        
        private func getDevelopmentDays() {
            GitHubParser.getDevelopmentDays(for: "sheikhbayazid") { [weak self] days in
                self?.days = days
            }
        }
        
    }
}
