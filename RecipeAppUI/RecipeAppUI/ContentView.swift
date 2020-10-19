//
//  ContentView.swift
//  RecipeAppUI
//
//  Created by Dustin yang on 10/18/20.
//

import SwiftUI

struct ContentView: View {
    @StateObject var manager = RecipeManager()
    @Namespace private var viewSpace

    var body: some View {
        ZStack{
            
            if manager.currentRecipe % 2 == 0 {
                Color.lightBackground.ignoresSafeArea()
                    .transition(.move(edge: .bottom))

            }else{
                Color.darkBackground.ignoresSafeArea()
                    .transition(.move(edge: .bottom))


            }
            RecipeOverviiew(manager: manager, viewSpace: viewSpace).padding(.horizontal)
            
            // recipe detail view
            
            if manager.selectedRecipe != nil{
                RecipeDetailView(manager: manager, viewSpace: viewSpace)
            }
            
        }
    }
}

struct RecipeOverviiew: View {
    @ObservedObject var manager :RecipeManager
    public var viewSpace: Namespace.ID

    var body: some View{
        VStack(alignment: .leading, spacing: 10){
            Spacer()

            //Title View
            TitleView(manager: manager)
            ZStack{
                RecipeInteractionView(recipe: manager.data[manager.currentRecipe], index: manager.currentRecipe,count: manager.data.count, manager: manager, viewSpace: viewSpace)
                    .rotationEffect(.degrees(Double(-manager.swipeHeight)))
                    .offset(x: UIScreen.screenWidth / 2)
                HStack{
                    //SummaryView
                    SummaryView(recipe: manager.data[manager.currentRecipe])
                        .foregroundColor(manager.currentRecipe%2 == 0 ?  .black : .white)

                    Spacer()
                }
            }
            DescriptionView(manager: manager)
            Spacer()
            
        }
    }
}

struct TitleView : View {
    @ObservedObject var manager :RecipeManager

    var body: some View{
        Text("Daily Cooking Quest").font(.system(size: 16, weight: .bold)).foregroundColor(.gray)
        Text(manager.data[manager.currentRecipe].title)
            .font(.system(size: 24, weight: .bold))
            .foregroundColor(manager.currentRecipe%2 == 0 ?  .black : .white)
    }
}

struct SummaryView : View {
    let recipe: RecipeItem
    
    var body: some View{
        VStack(alignment: .leading, spacing: 24){
            ForEach(recipe.summery.sorted(by: <), id: \.key) { key , value in
                HStack(spacing: 12){
                    Image(systemName: Data.summeryImageName[key] ?? "").foregroundColor(.green)
                    Text(value)
                }
                
              
            }
            
            HStack(spacing: 12){
                Image(systemName: "chart.bar.doc.horizontal").foregroundColor(.green)
                Text("Healthy")
            }.font(.system(size: 17, weight: .semibold))
            
        }
        
    }
}

struct DescriptionView : View {
    @ObservedObject var manager :RecipeManager


    var body: some View{
        HStack(spacing : 12){
            Text(manager.data[manager.currentRecipe].description).font(.system(size: 14, weight: .semibold))
                .foregroundColor(manager.currentRecipe%2 == 0 ?  .black : .white)

            Button(action: {
                withAnimation{
                    manager.selectedRecipe = manager.data[manager.currentRecipe]
                }
                
            }, label: {
                ZStack{
                    RoundedRectangle(cornerRadius: 10).fill(Color.green).frame(width: 50, height: 50).rotationEffect(.degrees(45))
                    
                    Image(systemName: "arrow.right").font(.system(size: 20, weight: .bold)).foregroundColor(.white)
                }
            })
            
            Spacer()
        }
    }
}

struct RecipeInteractionView : View {
    let recipe: RecipeItem
    let index : Int
    let count : Int
    @ObservedObject var manager :RecipeManager

    
    public var viewSpace: Namespace.ID
    var body: some View{
        ZStack{
            Circle().stroke(
                LinearGradient(gradient: Gradient(colors: [manager.currentRecipe%2 == 0 ? Color.lightBackground.opacity(0.1) : Color.darkBackground.opacity(0.1), Color.green, Color.green]), startPoint: .leading, endPoint: .trailing),lineWidth: 4
            ).scaleEffect(1.15)
            .matchedGeometryEffect(id: "borderId", in: viewSpace, isSource:  true)
            
            ArrowShape(reachedTop: index == 0, reachedBottom: index == count - 1).stroke(Color.gray, style: StrokeStyle(lineWidth: 2.5, lineCap: .round, lineJoin: .round)).frame(width: UIScreen.screenWidth-32, height: UIScreen.screenWidth-32).scaleEffect(1.15)
                .matchedGeometryEffect(id: "arrowId", in: viewSpace, isSource:  true)

            Image(recipe.imageName).resizable().scaledToFit()
                .matchedGeometryEffect(id: "imageId", in: viewSpace, isSource:  true)

            // This circle will be used to drag interaction
            Circle().fill(Color.black.opacity(0.001)).scaleEffect(1.2).gesture(DragGesture(minimumDistance: 10)
                 .onChanged({ (value) in
                    withAnimation{
                        manager.changeSwipevalue(value: value.translation.height)
                    }
                 }).onEnded({ (value) in
                    withAnimation{
                        manager.swipeEnded(value: value.translation.height)
                    }
                 })
            )
            
            
        }
    }
}

struct ArrowShape : Shape {
    let reachedTop : Bool
    let reachedBottom : Bool

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let startAngle : CGFloat = 160
        let endAngle : CGFloat = 200
        
        let radius  = rect.width / 2
        let startAngleRadian = startAngle * CGFloat.pi / 180
        let endAngleRadian = endAngle * CGFloat.pi / 180
        let startPoint1 = CGPoint.pointOnCircle(center: CGPoint(x: radius, y: radius), radius: radius, angle: startAngleRadian)
        let endPoint1 = CGPoint.pointOnCircle(center: CGPoint(x: radius, y: radius), radius: radius, angle: endAngleRadian)
        
        
        path.addArc(center: CGPoint(x: radius, y: radius),
                    radius: radius,
                    startAngle: .degrees(Double(startAngle)),
                    endAngle: .degrees(Double(endAngle)),
                    clockwise: false)
        
        
        if !reachedTop {
            let startAngleRadian2 = (startAngle + 4) * CGFloat.pi / 180
            let startPoint2 = CGPoint.pointOnCircle(center: CGPoint(x: radius, y: radius), radius: radius + 8, angle: startAngleRadian2)
            
            
            let startPoint3 = CGPoint.pointOnCircle(center: CGPoint(x: radius, y: radius), radius: radius - 8, angle: startAngleRadian2)
            
            
            path.move(to: startPoint1)
            path.addLine(to: startPoint2)
            
            path.move(to: startPoint1)
            path.addLine(to: startPoint3)
        }
        if !reachedBottom{
            let endAngleRadian2 = (endAngle - 4) * CGFloat.pi / 180
            let endPoint2 = CGPoint.pointOnCircle(center: CGPoint(x: radius, y: radius), radius: radius + 8, angle: endAngleRadian2)
            
            let endPoint3 = CGPoint.pointOnCircle(center: CGPoint(x: radius, y: radius), radius: radius - 8, angle: endAngleRadian2)
            
            path.move(to: endPoint1)
            path.addLine(to: endPoint2)
            
            path.move(to: endPoint1)
            path.addLine(to: endPoint3)
        }
        

        return path
    }
}

struct RecipeDetailView: View {
    @ObservedObject var manager :RecipeManager
    @State var isIngredient = false
    public var viewSpace: Namespace.ID

    var body: some View{
        ZStack{
            if manager.currentRecipe % 2 == 0 {
                Color.lightBackground.ignoresSafeArea()
                    .transition(.move(edge: .bottom))
                
            }else{
                Color.darkBackground.ignoresSafeArea()
                    .transition(.move(edge: .bottom))
                
                
            }
            
            ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: true){
                VStack(alignment: .leading){
                    //Image
                    RecipeInteractionView(recipe: manager.selectedRecipe ?? manager.data[0], index: manager.currentRecipe, count: manager.data.count, manager: manager, viewSpace: viewSpace).rotationEffect(.degrees(90)).offset(y: -80)
                    
                    
                    Group{
                        //title
                        Text(manager.selectedRecipe?.title ?? "?")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(manager.currentRecipe%2 == 0 ?  .black : .white)
                        
                        HStack(spacing: 32){
                            HStack(spacing: 12){
                                Image(systemName: Data.summeryImageName["time"] ?? "?")
                                    .foregroundColor(.green)
                                Text(manager.selectedRecipe?.summery["time"] ?? "?")
                                
                                
                            }
                            
                            HStack(spacing: 12){
                                Image(systemName: Data.summeryImageName["ingredientCount"] ?? "?")
                                    .foregroundColor(.green)
                                
                                Text(manager.selectedRecipe?.summery["ingredientCount"] ?? "?")
                                
                                
                            }
                        }
                        .foregroundColor(manager.currentRecipe%2 == 0 ?  .black : .white)
                        .padding(.vertical)
                    }.padding(.horizontal)
                    
                    // igredient / step toggle view
                    Toggle(isOn: $isIngredient, label: {
                    }).toggleStyle(IngredientMethodToggleStyle())
                    .foregroundColor(manager.currentRecipe%2 == 0 ?  .black : .white)

                    
                    if isIngredient{
                        // ingredient list
                        IngredientListView(manager: manager)
                    }else{
                        MethodListView(method: manager.selectedRecipe?.instrusctions ?? ["?"])
                            .foregroundColor(manager.currentRecipe%2 == 0 ?  .black : .white)

                    }
                    
                }
            }
            
            BackButttonView(manager: manager)
                .foregroundColor(manager.currentRecipe%2 == 0 ?  .black : .white)

        }
    }
}


struct BackButttonView : View{
    @ObservedObject var manager :RecipeManager

    var body: some View{
        VStack{
            Button(action: {
                withAnimation{
                    manager.selectedRecipe = nil
                }
            }, label: {
                
                HStack{
                    Image(systemName: "arrow.left").font(.system(size: 20, weight: .bold)).padding(24)
                    Spacer()
                }
                
            })
            Spacer()

        }
    }
    
}

struct IngredientMethodToggleStyle : ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        return
            VStack(alignment : .leading){
                HStack{
                    Text("INGREDIENTS")
                        .font(.system(size: 16, weight: configuration.isOn ? .bold : .regular))
                        .frame(width: 110).fixedSize().animation(nil).padding(4).padding(.leading, 12)
                        .onTapGesture{
                            withAnimation{
                                configuration.isOn = true
                            }
                        }
                    
                    Text("METHOD")
                        .font(.system(size: 16, weight: configuration.isOn ? .regular : .bold))
                        .animation(nil).padding(4)
                        .onTapGesture{
                            withAnimation{
                                configuration.isOn = false
                            }
                        }

                }
                
                ZStack(alignment : .leading){
                    Rectangle().fill(Color.gray.opacity(0.3)).frame(height: 3)
                    Rectangle().fill(Color.green).frame(width: configuration.isOn ? 110: 70, height: 3)
                        .offset(x: configuration.isOn ? 16 :  140)

                }
                
            }
    }
    
}

struct IngredientListView : View {
    @ObservedObject var manager :RecipeManager

    var body: some View{
        ForEach(0..<manager.data[manager.currentRecipe].instrusctions.count){ i in
            Toggle(isOn: Binding<Bool>(
                get:{manager.data[manager.currentRecipe].ingredients[i].available},
                set:{manager.data[manager.currentRecipe].ingredients[i].available = $0}
            
            ), label: {
                Text(manager.data[manager.currentRecipe].ingredients[i].title)
                    .foregroundColor(manager.currentRecipe%2 == 0 ?  .black : .white)

            }).toggleStyle(CircularToggleStyle()).padding(.vertical, 8)
            
        }
        
    }
}


struct CircularToggleStyle : ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        return
            HStack(alignment: .top){
                ZStack{
                    Circle().stroke(configuration.isOn ? Color.green: Color.gray.opacity(0.5), lineWidth: 2).frame(width: 20, height: 20)
                    
                    if configuration.isOn{
                        Circle().fill(Color.green).frame(width: 10, height: 10)
                    }
                }.padding(.horizontal)
                
                configuration.label

            }.onTapGesture{
                withAnimation{
                    configuration.isOn.toggle()

                }
            }
    }
    
}



struct MethodListView : View {
    let method : [String]

    var body: some View{
        ForEach(method, id:\.self){ value in
            Text(value).padding(.horizontal).padding(.vertical)
            
        }
        
    }
}

class RecipeManager: ObservableObject {
    @Published var data = Data.recipes
    @Published var selectedRecipe : RecipeItem? = nil

//    @Published var selectedRecipe : RecipeItem? = Data.recipes[0]
    @Published var swipeHeight : CGFloat = 0.0
    
    var currentRecipe = 0
    
    func changeSwipevalue(value: CGFloat){
        swipeHeight = value / 3
    }
    
    
    func swipeEnded(value: CGFloat){
        if value / 3 > 20 || value/3 < -20{
            var isChanged = false
            if swipeHeight > 0 {
                if currentRecipe > 0 {
                    currentRecipe -= 1
                    swipeHeight = 360.0
                    isChanged = true
                }
                
            }else if swipeHeight < 0 {
                if currentRecipe < data.count-1 {
                    currentRecipe += 1
                    swipeHeight = -360.0
                    isChanged = true
                }
            }
            if isChanged{
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7){
                    self.swipeHeight = 0.0
                }
            }else{
                swipeHeight = 0.0
            }
            
        }else{
            swipeHeight = 0.0
        }
    }
}




extension CGPoint{
    static func pointOnCircle(center : CGPoint, radius: CGFloat, angle: CGFloat) -> CGPoint {
        let x = center.x + radius * cos(angle)
        let y = center.y + radius * sin(angle)
        return CGPoint(x: x, y: y)
    }
}

extension Color {
    static let lightBackground = Color.init(red: 243/255, green:  243/255, blue:  243/255)
    static let darkBackground = Color.init(red: 34/255, green:  51/255, blue:  68/255)
}

extension UIScreen{
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenSize = UIScreen.main.bounds.size
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
