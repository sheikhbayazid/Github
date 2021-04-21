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
            Text("Github Contribution Stats")
                .font(.title3)
                .foregroundColor(.primary)
                .padding(.horizontal, 10)
                .padding(.vertical, 15)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
            
            Spacer()
            
            ZStack {
                ContributionGraphView(
                    days: viewModel.days,
                    selectedDay: { viewModel.selectedDay = $0 }
                )
                
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
            }.frame(width: UIScreen.main.bounds.size.width - 50, height: 150)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.green,lineWidth: 1))
            
            if let selectedDay = viewModel.selectedDay {
                Text("\(selectedDay.dataCount) contribution(s) on \(DateService.shared.dateFormatterForView.string(from: selectedDay.date))")
            }
            
            Spacer()
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
