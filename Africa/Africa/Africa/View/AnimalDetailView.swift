//
//  AnimalDetailView.swift
//  Africa
//
//  Created by Dustin yang on 10/15/20.
//

import SwiftUI

struct AnimalDetailView: View {
    let animal: Animal
    var body: some View {
        ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false) {
            VStack(alignment: .center, spacing: 20){
                Image(animal.image).resizable().scaledToFit()
                //title
                
                Text(animal.name.uppercased()).font(.largeTitle).fontWeight(.heavy).multilineTextAlignment(.center)
                    .padding(.vertical, 8).foregroundColor(.primary).background(Color.accentColor.frame(height: 6).offset(y: 24))
                
                //head line
                
                Text(animal.headline).font(.headline).multilineTextAlignment(.leading).foregroundColor(.accentColor)
                    .padding(.horizontal)
                
                Group{
                    HeadingView(headingImage: "photo.on.rectangle.angled", headingText: "Wilderness in Pictures")
                    InsertGalleryView(animal: animal)
                }.padding(.horizontal)
            }
            
        }.navigationBarTitle("Learn about \(animal.name)", displayMode: .inline)
    }
}

struct AnimalDetailView_Previews: PreviewProvider {
    static let animals : [Animal] = Bundle.main.decode("animals.json")
    static var previews: some View {
        
        NavigationView{
            AnimalDetailView(animal: animals[0])
        }.previewDevice("iPhone 11 Pro")
        
     
//            .previewLayout(.sizeThatFits).padding()
    }
    

}
