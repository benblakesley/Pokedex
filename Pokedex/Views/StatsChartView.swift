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
        Chart {
            ForEach(stats, id: \.stat.name) { stat in
                BarMark(
                    x: .value("Value", stat.baseStat),
                    y: .value("Stat", stat.stat.name)
                )
                .foregroundStyle(statColors[StatCategory.category(for: stat.baseStat)] ?? .clear)
            }
        }
        .padding()
        .frame(height: 300)
        .chartXAxis(.hidden)
        .chartXScale(domain: 0...160)
    }
}

//#Preview {
//    StatsChartView()
//}
