//
//  ContentView.swift
//  CircleAnimation
//
//  Created by Jijo on 03/08/22.
//

import SwiftUI

struct ContentView: View {
    @State private var rotation: Double = 0
    var body: some View {
        ZStack{
            Color.black.edgesIgnoringSafeArea(.all)
            CirclesList()
                .rotation3DEffect(.degrees(rotation), axis: (x: 0, y: 1, z: 0))
        }.task {
            Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
                withAnimation(Animation.linear(duration: 0.1)) {
                    self.rotation += 1
                }
            }
        }
    }
}

struct CirclesList: View {
    let colorList: [Color] =  [.white,
                               .red,
                               .orange,
                               .yellow,
                               .green,
                               .blue,
                               .purple]
    var body: some View {
        VStack {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                ForEach(0..<14, id: \.self) { i in
                    AnimatedCircles(index: i,
                                    color: colorList[i % 7])
                }
            }
        }
        
    }
}

struct AnimatedCircles: View {
    @State var index: Int
    @State private var animate: Bool = true
    @State private var yOffsetValue: CGFloat = -0
    @State var color: Color = .blue
    var body: some View {
        Circle()
            .stroke(lineWidth: 2)
            .frame(width:  20 + CGFloat(index * 15))
            .foregroundColor(color)
            .rotation3DEffect(.degrees(75), axis: (x: 1, y: 0, z: 0))
            .offset(y: animate ? yOffsetValue : 0)
            .animation(Animation.easeInOut(duration: 2.0).delay(0.1 * Double(index)), value: animate)
            .onAppear() {
                animateCircle()
                Timer.scheduledTimer(withTimeInterval: 6, repeats: true) { _ in
                    animateCircle()
                }
            }
    }
    
    func animateCircle() {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            animate.toggle()
            yOffsetValue = 0
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            animate.toggle()
            yOffsetValue = 200
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            animate.toggle()
            yOffsetValue = 0
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                animate.toggle()
                yOffsetValue = -200
            }
        }
    }
}

struct AnimateCirclesDevelop_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

