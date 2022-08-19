//
//  ContentView.swift
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Arc(startAngle: .degrees(0),
            endAngle: .degrees(180),
            clockwise: true)
        .stroke(.blue, lineWidth: 10)
        .frame(width: 300, height: 300)
        
    }
}

struct Arc: Shape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool

    func path(in rect: CGRect) -> Path {
        let rotationAdjustment = Angle.degrees(90)
        let modifiedStart = startAngle - rotationAdjustment
        let modifiedEnd = endAngle - rotationAdjustment
        
        var path = Path()
        path.addArc(
            center: CGPoint(x: rect.midX, y: rect.midY),
            radius: rect.width / 2,
            startAngle: modifiedStart,
            endAngle: modifiedEnd,
            clockwise: clockwise
        )

        return path
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
