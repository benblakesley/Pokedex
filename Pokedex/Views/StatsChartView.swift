//
//  StatsChartView.swift
//  Pokedex
//
//  Created by Ben Blakesley on 14/10/2024.
//

import SwiftUI
import Charts

struct StatsChartView: View {

    var stats: [Stat]

    var body: some View {
        
        HStack
        {
            let chartHeight = 300.0
            
            Chart {
                ForEach(stats, id: \.stat.name) { stat in
                    BarMark(
                        x: .value("Value", stat.baseStat),
                        y: .value("Stat", stat.stat.name.rawValue)
                    )
                    .foregroundStyle(statColors[StatCategory.category(for: stat.baseStat)] ?? .clear)
                }
            }
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            .frame(height: chartHeight)
            .chartXAxis(.hidden)
            .chartXScale(domain: 0...250)
            
            VStack(spacing: 0)
            {
                ForEach(stats, id: \.stat.name) { stat in
                    Text("\(stat.baseStat)")
                        .frame(height: chartHeight/6, alignment: .bottom)
                        .fontWeight(.semibold)
                }
            }
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
        }
    }
}
