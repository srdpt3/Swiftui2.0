//
//  Created by Robert Petras
//  SwiftUI Masterclass ♥ Better Apps. Less Code.
//  https://swiftuimasterclass.com
//

import SwiftUI

struct VideoListView: View {
    @State var videos : [Video] = Bundle.main.decode("videos.json")
    let hapticImapact = UIImpactFeedbackGenerator(style: .medium)
    
    var body: some View {
        NavigationView {
            List{
                ForEach(videos) { item in
                    NavigationLink(
                        destination: VideoPlayerView(videoSelected: item.id, videTitle: item.name)){
                        VideoListItem(video: item).padding(.vertical, 8)
                    }
                      
                }
                
            }.listStyle(InsetGroupedListStyle())
            .navigationBarTitle("Videos", displayMode:.inline).toolbar {
                ToolbarItem(placement: .navigationBarTrailing){
                    Button(action: {
                        videos.shuffle()
                        hapticImapact.impactOccurred()
                    }){
                        Image(systemName: "arrow.2.squarepath")
                    }
                    
                }
            }
        }
    }
}

struct VideoListView_Previews: PreviewProvider {
    static var previews: some View {
        VideoListView()
            .previewDevice("iPhone 11 Pro")
    }
}
