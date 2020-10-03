//
//  ContentView.swift
//  nikeShoes
//
//  Created by Dustin yang on 9/29/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {

        Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home : View {
    
    var black = Color.black.opacity(0.7)
    var width = UIScreen.main.bounds.width
    @State var more = false
    @State var gender = "Male"
    @State var size = 6
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    @State var added = false
    
    var body: some View{
        
        VStack{
            
            ZStack{
                
                HStack{
                    
                    Button(action: {}) {
                        
                        Image(systemName: "chevron.left")
                            .font(.system(size: 22))
                            .foregroundColor(.white)
                            .frame(width: 40, height: 40)
                            .background(Color("red"))
                            .cornerRadius(10)
                            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 5, y: 5)
                    }
                    
                    Spacer(minLength: 0)
                    
                    Button(action: {}) {
                        
                        Image(systemName: "suit.heart")
                            .font(.system(size: 22))
                            .foregroundColor(black)
                            .frame(width: 40, height: 40)
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 5, y: 5)
                    }
                }
                
                Image("nike")
                    .resizable()
                    .frame(width: 55, height: 55)
            }
            .padding()
            
            Image("shoe1")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: width - (more ? 200 : 100))
                .padding(.top,25)
            
                
                // For Smaller iPhones....
                
            ScrollView(UIScreen.main.bounds.height < 750 ? .vertical : .init(), showsIndicators: false) {
                    
                    VStack{
                        
                        HStack{
                            
                            Text("나이키 줌 에어 \n페가수스 36")
                                .font(.title2)
                                .fontWeight(.heavy)
                                .foregroundColor(black)
                            
                            Spacer(minLength: 0)
                            
                            Text("세일가격: 88,000원")
                                .font(.title2)
                                .fontWeight(.heavy)
                                .foregroundColor(Color("red"))
                        }
                        .padding(.top,25)
                        .padding(.trailing)
                        
                        VStack(alignment: .leading, spacing: 5) {
                            
                            Text("스포츠화 / 런닝화 / 로우탑 / 메인소재: 폴리에스테르+합성 플라스틱 / 소재특징: 메쉬 / 색상: 블랙+화이트+썬더 그레이 / 출시가: 139,000원")
                                .lineLimit(more ? nil : 3)
                                .foregroundColor(black)
                            
                            Button(action: {withAnimation{more.toggle()}}) {
                                
                                Text(more ? "Less" : "Read More")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("red"))
                            }
                        }
                        .padding([.vertical,.trailing])
                        
                        HStack(spacing: 15){
                            
                            Text("성별")
                                .fontWeight(.heavy)
                                .foregroundColor(black)
                                .frame(width: 75,alignment: .leading)
                            
                            GenderButton(gender: $gender, title: "남성")
                            
                            GenderButton(gender: $gender, title: "여성")
                            
                            Spacer(minLength: 0)
                        }
                        .padding(.trailing)
                        .padding(.top,10)
                        
                        HStack(spacing: 15){
                            
                            Text("사이즈")
                                .fontWeight(.heavy)
                                .foregroundColor(black)
                                .frame(width: 75,alignment: .leading)
                            
                            ForEach(sizes,id: \.self){title in
                                
                                SizeButton(size: $size, title: title)
                            }
                            
                            Spacer(minLength: 0)
                        }
                        .padding(.trailing)
                        .padding(.top,10)
                        
                        Spacer(minLength: 0)
                        
                        Button(action: {added.toggle()}) {
                            
                            Label(title: {
                                Text(added ? "장바구니로 이동" : "장바구니에 담기")
                                    .font(.title2)
                                    .foregroundColor(.white)
                                    .fontWeight(.heavy)
                            }) {
                                
                                Image(systemName: added ? "checkmark.circle.fill" : "cart.fill")
                                    .font(.system(size: 22))
                                    .foregroundColor(.white)
                            }
                            .padding(.vertical,12)
                            // padding 30 + 45 = 75
                            .frame(width: width - 75)
                            .background(added ? Color.green : Color("red"))
                            .clipShape(Capsule())
                            .padding(.leading,-45)
                            .padding(.top)
                            .padding(.bottom,edges!.bottom == 0 ? 15 : edges!.bottom)
                        }
                    }
                    .padding(.leading,45)
                }
                .background(Color.white)
            // its asking some thing here I dont know may be its bug...
                .shadow(radius: 0)
                .clipShape(CustomShape())
                .padding(.top,30)
                .shadow(color: Color.black.opacity(0.12), radius: 5, x: -5, y: -10)
            
        }
        .background(Color("bg").ignoresSafeArea(.all, edges: .all))
        .ignoresSafeArea(.all, edges: .bottom)
    }
}

struct CustomShape : Shape {
    
    func path(in rect: CGRect) -> Path {
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft], cornerRadii: CGSize(width: 85, height: 85))
        
        return Path(path.cgPath)
    }
}

struct GenderButton : View {
    
    @Binding var gender : String
    var title : String
    var black = Color.black.opacity(0.7)
    
    var body: some View{
        
        Button(action: {gender = title}) {
            
            Text(title)
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(gender == title ? .white : black)
                .padding(.vertical,10)
                .frame(width: 80)
                .background(gender == title ? Color("red") : Color.white)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 5, y: 5)
        }
    }
}

struct SizeButton : View {
    
    @Binding var size : Int
    var title : Int
    var black = Color.black.opacity(0.7)
    
    var body: some View{
        
        Button(action: {size = title}) {
            
            Text("\(title)")
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(size == title ? .white : black)
                .frame(width: 35,height: 35)
                .background(size == title ? Color("red") : Color.white)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 5, y: 5)
        }
    }
}

var sizes = [6,7,8,9,10]
