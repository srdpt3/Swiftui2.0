//
//  Created by Robert Petras
//  SwiftUI Masterclass ♥ Better Apps. Less Code.
//  https://swiftuimasterclass.com 
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    
    
    
    let animals: [Animal] = Bundle.main.decode("animals.json")
    NavigationView{
        List{
            CoverImageview().frame(height: 300).listRowInsets(EdgeInsets(top: 0 , leading:  0 , bottom: 0, trailing: 0 ))
            
            ForEach(animals){ animal in
                NavigationLink(destination: AnimalDetailView(animal: animal)){
                    AnimalListItemView(animal: animal)

                }
                   
            }
            
        }.navigationBarTitle("Africa - by Dustin", displayMode: .large)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .previewDevice("iPhone 11 Pro")
  }
}
