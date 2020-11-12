//
//  Created by Robert Petras
//  SwiftUI Masterclass ♥ Better Apps. Less Code.
//  https://swiftuimasterclass.com
//

import SwiftUI

struct GalleryView: View {
    
    @State private var selectedAnimal : String = "lion"
    let animals: [Animal] = Bundle.main.decode("animals.json")
    
    //    let gridLayout : [GridItem] = [
    //        GridItem(.flexible()),
    //        GridItem(.flexible()),
    //        GridItem(.flexible())
    //
    //    ]
    
    //    let gridLayout : [GridItem] =  Array(repeating: GridItem(.flexible()), count: 3)
    @State  private var gridLayout : [GridItem] =  [GridItem(.flexible())]
    @State  private var gridColumn : Double = 3.0
    
    func gridSwitch(){
        gridLayout = Array(repeating: GridItem(.flexible()), count: Int(gridColumn))
    }
    
    var body: some View {
        ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false){
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 30){
                
                //MARK - IMAGE
                Image(selectedAnimal)
                    .resizable().scaledToFit()
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 8))
                
                //Slider
                
                Slider(value: $gridColumn, in: 2...4, step: 1)
                    .padding(.horizontal).onChange(of: gridColumn, perform: { value in
                        gridSwitch()
                    })
                
                //MARK: - GRID
                LazyVGrid(columns: gridLayout, alignment: .center, spacing: 10){
                    
                    ForEach(animals) { item in
                        Image(item.image)
                            .resizable().scaledToFit()
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 1))
                            .onTapGesture{
                                selectedAnimal = item.image
                            }
                    }
                }
                .animation(.easeIn)
                .onAppear(perform:{
                    gridSwitch()
                    
                })
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 50)
            
        }
        //        .frame(minWidth: .infinity,maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
    }
}

struct GalleryView_Previews: PreviewProvider {
    static var previews: some View {
        GalleryView()
            .previewDevice("iPhone 11 Pro")
    }
}
