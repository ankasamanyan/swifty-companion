//
//  SkillView.swift
//  swifty-companion
//
//  Created by Anait Kasamanian on 13.07.24.
//

import Foundation
import SwiftUI
import Charts

struct SkillView: View {
    var skills: [Skill]

    private func truncatedSkillName(_ name: String, length: Int) -> String {
          if name.count > length {
              let endIndex = name.index(name.startIndex, offsetBy: length)
              return String(name[..<endIndex]) + "..."
          }
          return name
      }
    
    var body: some View {
       let skillData = skills.map { ToyShape(type: $0.name, count: $0.level)}

       SectionView(title: "Skills") {
           if skills.isEmpty {
               Text("No skills yet")
                   .foregroundColor(.gray)
           }
           else
           {
               Chart {
                   ForEach(skillData) { skill in
                       BarMark(
                           x: .value("Skill", skill.type),
                           y: .value("Level", skill.count)
                       )
                       .annotation(position: .bottom, alignment: .leading) {
                           Text(truncatedSkillName(skill.type, length: 15))
                               .font(.caption)
                               .foregroundColor(.indigo)
                               .rotationEffect(.degrees(45), anchor: .leading)
                               .padding(.leading, 10)
                       }
                       .annotation(position: .top, alignment: .leading) {
                           Text( String(format: "%.2f", skill.count))
                               .foregroundColor(.indigo)
                               .font(.caption)

                       }

                   }
               }
               .chartXAxis(.hidden)
               .frame(height: 300)
           }
       }
   }
}

struct ToyShape: Identifiable {
    var type: String
    var count: Double
    var id = UUID()
}
