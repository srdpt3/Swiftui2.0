//
//  ContentView.swift
//  StepCounter
//
//  Created by Dustin yang on 10/3/20.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
           ZStack {
               AngularGradient(
                   gradient: ColorConstants.backgroundGradient,
                   center: .bottomTrailing,
                   startAngle: .degrees(170),
                   endAngle: .degrees(270))
                   .blur(radius: 70, opaque: true)
               
               VStack {
                   TopBarView()
                       .padding(.leading, 20)
                       .padding(.trailing, 20)
                       .padding(.top, 44)
                   ProgressGoalView()
                       .padding(.top, 40)
                   
                   Spacer()
                   
                   InfoDashboardView()
                       .padding(.leading, 40)
                       .padding(.trailing, 40)
                   
                   Spacer()
                   
                   PlayPauseView()
                       .padding(.bottom, 40)
               }
           }
           .edgesIgnoringSafeArea(.all)
           .environmentObject(StepCountManager())
       }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct TopBarView: View {
    var body: some View {
        HStack {
            Image(systemName: "line.horizontal.3")
            Spacer()
            Text("오늘 10월3일 - 1일1앱")
            Spacer()
            Image(systemName: "bell.badge.fill")
        }
        .foregroundColor(.white)
        .font(.title)
    }
}


struct ProgressGoalView: View {
    @EnvironmentObject var manager: StepCountManager
    var body: some View {
        ZStack {
            Circle()
                .stroke(RadialGradient(
                            gradient: Gradient(colors: [Color.black.opacity(0.2), Color.white.opacity(0.3)]),
                            center: .center,
                            startRadius: 80,
                            endRadius: 300),
                        lineWidth: 40)
                .frame(width: 260, height: 260)
            
            Circle()
                .trim(from: 0.0, to: manager.goalPercentage)
                .stroke(LinearGradient(
                            gradient: Gradient(
                                colors: [ColorConstants.bottomColor2, Color.red]),
                            startPoint: .top,
                            endPoint: .trailing),
                        style: StrokeStyle(
                            lineWidth: 40,
                            lineCap: .round))
                .frame(width: 260, height: 260)
                .rotationEffect(.degrees(-90))
                .shadow(color: ColorConstants.bottomColor2, radius: 30)
            
            VStack(spacing: 12) {
                Text("목표 걸음수: \(getFormeattedInt(number: manager.stepData.goal))")
                    .font(.system(size: 18))
                Text("\(getFormeattedInt(number: manager.stepData.count))")
                    .font(.system(size: 56))
            }
            .foregroundColor(.white)
                
        }
    }
    
    func getFormeattedInt(number: Int) -> String {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = false
        return formatter.string(from: NSNumber(value: number))!
    }
}


struct InfoDashboardView: View {
    @EnvironmentObject var manager: StepCountManager
    var body: some View {
        HStack {
            DataItemView(dataItem: manager.statData[0])
            
            Spacer()
            
            Rectangle()
                .fill(Color.white)
                .frame(width: 1, height: 200)
                .opacity(0.2)
            
            Spacer()
            
            DataItemView(dataItem: manager.statData[1])
            
            Spacer()
            
            Rectangle()
                .fill(Color.white)
                .frame(width: 1, height: 200)
                .opacity(0.2)
            
            Spacer()
            
            DataItemView(dataItem: manager.statData[2])
        }
    }
}

struct DataItemView: View {
    let dataItem: DataItem
    var body: some View {
        VStack {
            Image(systemName: dataItem.imageName)
                .foregroundColor(dataItem.imageColor)
                .font(.system(size: 48))
                .shadow(color: dataItem.imageColor.opacity(0.5), radius: 10, x: 4, y: 24)
            
            Text(dataItem.value)
                .font(.system(size: 36, design: .monospaced))
                .fixedSize()
                .frame(width: 60)
                .padding(.top, 20)
                .padding(.bottom, 10)
            
            Text(dataItem.unit)
                .font(.system(size: 22))
        }
        .foregroundColor(.white)
    }
}



struct PlayPauseView: View {
    @EnvironmentObject var manager: StepCountManager
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 35)
                .fill(Color.white)
                .frame(width: 170, height: 70)
                .shadow(color: Color.black.opacity(0.5), radius: 20, x: 5.0, y: 15.0)
            
            HStack {
                ZStack {
                    Circle()
                        .fill(ColorConstants.bottomColor2)
                        .frame(width: 60, height: 60)
                    
                    Image(systemName: manager.start ? "pause.fill" : "play.fill")
                        .font(.title)
                        .foregroundColor(.white)
                }
                
                Text(manager.start ? "중지" : "시작")
                    .font(.system(size: 24))
                    .bold()
                    .fixedSize()
                    .frame(width: 60)
                    .padding(.leading, 8)
                    
            }
            .offset(x: -12)
        }
        .onTapGesture {
            manager.updateData()
        }
    }
}


let data = [
    DataItem(imageName: "drop.fill", imageColor: Color.blue, value: "0", unit: "마일"),
    DataItem(imageName: "flame.fill", imageColor: Color.orange, value: "0", unit: "칼로리"),
    DataItem(imageName: "stopwatch.fill", imageColor: Color.green, value: "0\u{1D0D}", unit: "시간")
]

struct DataItem {
    let id = UUID()
    let imageName: String
    let imageColor: Color
    var value: String
    let unit: String
}

struct StepData {
    var count: Int = 0
    var mileCount: CGFloat = 0
    var caloryCount: Int = 0
    var minuteCount: Int = 0
    var goal: Int
}




struct ColorConstants {
    static let topColor1        = Color.init(red: 31/255, green: 15/255, blue: 119/255)
    static let topColor2        = Color.init(red: 12/255, green: 39/255, blue: 186/255)
    static let bottomColor1     = Color.init(red: 100/255, green: 24/255, blue: 131/255)
    static let bottomColor2     = Color.init(red: 221/255, green: 19/255, blue: 130/255)
    
    static let backgroundGradient = Gradient(
        colors: [bottomColor1, bottomColor2, topColor1, topColor2])
}
