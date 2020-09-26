//
//  ContentView.swift
//  FashinApp_translucentBackground
//
//  Created by Dustin yang on 9/26/20.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View{
        Home()
    }
}


struct Home: View {
    
    // 40 = padding horizontal
    // 60 = 2 card to right side...
    
    var width = UIScreen.main.bounds.width - (40 + 60)
    var height = UIScreen.main.bounds.height / 2
    @State var books = [
        
        // Make Sure id is in ascending Order....
        
        Book(id: 0, image: "p1", title: "H Strie 벨트 버클 & 리버서블 가죽 스트랩 32mm", author: "₩ 1,140,000", rating: 3, offset: 0),
        Book(id: 1, image: "p0", title: "Hermes Cinhetic 백", author: "₩ 11,120,000", rating: 4, offset: 0),
        Book(id: 2, image: "p3", title: "Trocadero 뮬", author: "₩ 1,300,000", rating: 4, offset: 0),
        Book(id: 3, image: "p2", title: "Oran 샌들", author: "₩ 800,000", rating: 5, offset: 0),
        Book(id: 4, image: "p5", title: "Hermes 2002 - 20 백", author: "₩ 11,650,000", rating: 4, offset: 0),
        Book(id: 5, image: "p4", title: "Hermes 2002 - 20 백", author: "₩ 11,650,000", rating: 4, offset: 0),
    ]
    
    @State var swiped = 0
    var body: some View{
        
        VStack{
            HStack{
                VStack{
                    Text("Hermes " )
                        .font(.title)
                        .fontWeight(.heavy)
                    
                    Text(" FW 2020콜랙션")
                        .font(.title)
                        .fontWeight(.heavy)
                }
             
                
                Spacer(minLength: 0)
                
                Button(action: {}) {
                    
                    Image(systemName: "circle.grid.2x2.fill")
                        .font(.system(size: 22))
                    
                }
            }
            .foregroundColor(.white)
            .padding()
            
            
            Spacer(minLength: 0)
            
            ZStack{
                
                // since its zstack it overlay one on another so reversed....
                
                ForEach(books.reversed()){book in
                    
                    HStack{
                        
                        ZStack{
                            
                            Image(book.image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: width, height: getHeight(index: book.id))
                                .cornerRadius(25)
                                // Little Shadow...
                                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5)
                            
                            // Read More Button...
                            
                            CardView(card: book)
                                .frame(width: width, height: getHeight(index: book.id))
                        }
                        .offset(x: book.id - swiped < 3 ? CGFloat(book.id - swiped) * 30 : 60)
                        
                        Spacer(minLength: 0)
                    }
                    // Content Shape For Drag Gesture...
                    .contentShape(Rectangle())
                    .padding(.horizontal,20)
                    // gesture...
                    .offset(x: book.offset)
                    .gesture(DragGesture().onChanged({ (value) in
                        withAnimation{onScroll(value: value.translation.width, index: book.id)}
                    }).onEnded({ (value) in
                        withAnimation{onEnd(value: value.translation.width, index: book.id)}
                    }))
                }
            }
            // max height...
            .frame(height: height)
            
            PageViewController(total: books.count, current: $swiped)
                .padding(.top,25)
            
            Spacer(minLength: 0)
            
        }.background(Color("bg").ignoresSafeArea(.all, edges: .all))
        
    }
    // dynamic height Change...
    
    func getHeight(index : Int)->CGFloat{
        
        // two card = 80
        // all other are 80 at background....
        
        // automatic height and offset adjusting...
        
        return height - (index - swiped < 3 ? CGFloat(index - swiped) * 40 : 80)
    }
    
    func onScroll(value: CGFloat,index: Int){
        
        if value < 0{
            
            // Left Swipe...
            
            if index != books.last!.id{
                
                books[index].offset = value
            }
        }
        else{
            
            // Right Swipe....
            
            // Safe Check...
            if index > 0{
                
                if books[index - 1].offset <= 20{
                    
                    books[index - 1].offset = -(width + 40) + value
                }
            }
        }
    }
    
    func onEnd(value: CGFloat,index: Int){
        
        if value < 0{
            
            if -value > width / 2 && index != books.last!.id{
                
                books[index].offset = -(width + 100)
                swiped += 1
            }
            else{
                
                books[index].offset = 0
            }
        }
        else{
            
            if index > 0{
                
                if value > width / 2{
                    
                    books[index - 1].offset = 0
                    swiped -= 1
                }
                else{
                    
                    books[index - 1].offset = -(width + 100)
                }
            }
        }
    }
}

struct CardView : View {
    
    var card : Book
    @State var showSafari = false

    var body: some View{
        
        VStack{
            
            // You can display all details
            // I'm displaying only read button....
            Spacer(minLength: 0)
            
            HStack{
                
                Button(action: {
                    self.showSafari = true
                    
                }) {
                    
                    Text("자세히 보기")
                        .font(.system(size: 14))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.vertical,5)
                        .padding(.horizontal,10)
                        .background(Color("purple"))
                        .clipShape(Capsule())
                    Text(card.title)
                        .font(.caption)                        .foregroundColor(.gray)         .font(.system(size: 16))

                    
                }
                
                Spacer(minLength: 0)
            } .sheet(isPresented: $showSafari) {
                SafariView(url:URL(string: "https://www.hermes.com/kr/ko/product/hermes-2002---20-%EB%B0%B1-H075134CK89/")!)
//                SafariView(url: "google.com")
            }
            .padding()
            .padding(.bottom,10)
        }
        
    }
}


// Carousel Model Book Data...

struct Book : Identifiable {
    
    var id: Int
    var image : String
    var title : String
    var author : String
    var rating : Int
    var offset : CGFloat
}

// Paging COntrol...

struct PageViewController : UIViewRepresentable {
    
    var total : Int
    @Binding var current : Int
    
    func makeUIView(context: Context) -> UIPageControl {
        
        let view = UIPageControl()
        view.numberOfPages = total
        view.currentPage = current
        view.currentPageIndicatorTintColor = .white
        view.preferredIndicatorImage = UIImage(systemName: "heart.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 22))
        view.backgroundStyle = .prominent
        
        return view
    }
    
    func updateUIView(_ uiView: UIPageControl, context: Context) {
        
        uiView.currentPage = current
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}


import SafariServices

struct SafariView: UIViewControllerRepresentable {
    
    let url: URL

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
        
    }
    
    func makeUIViewController(context: Context) -> SFSafariViewController {
        let safariVC = SFSafariViewController(url: self.url)
        return safariVC
    }
}

