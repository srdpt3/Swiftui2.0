//
//  ContentView.swift
//  Daily_task_widget_ios
//
//  Created by Dustin yang on 3/13/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    //MARK : - PROPERTY
    @AppStorage("isDarkMode") private var isDarkMode : Bool = false
    @State var task : String = ""
    @State private var showNewTaskItem: Bool = false
    
    // FETCHING DATA
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    
    //MARK: - FUNCTION
    
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    
    var body: some View {
        NavigationView {
            ZStack {
                //MARK - MAIN VIEW
                
                VStack {
                    //HEADER
                    HStack(spacing:30){
                        Text("To-Do").font(.system(.largeTitle, design: .rounded))
                            .fontWeight(.heavy).padding(.leading,10)
                            .foregroundColor(.white)
                        Spacer()
                        
                        EditButton().font(.system(size: 16, weight: .semibold, design: .rounded))
                            .padding(.horizontal,-5)
                            
                            .frame(width: 70, height: 24)
                            .background(Capsule().stroke(Color.white,lineWidth: 2))
                            .foregroundColor(.white)
                        //
                        
                        Button(action: {
                            isDarkMode.toggle()
                        }, label: {
                            Image(systemName: isDarkMode ?"moon.circle.fill": "moon.circle").resizable()
                                .frame(width: 24, height: 24)
                                .font(.system(.title, design: .rounded))
                                .padding(.trailing,10)
                                .foregroundColor(.white)
                        })
                    }
                    
                    
                    Spacer(minLength: 80)
                    
                    // MARK - NEW TASK Button
                    Button(action: {
                        showNewTaskItem=true
                    }, label: {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 30, weight: .semibold, design: .rounded))
                            .foregroundColor(.white)

                        Text("New Task")
                            .font(.system(size: 24, weight:  .bold  , design: .rounded))
                            .foregroundColor(.white)
                        
                        
                    })
                    
                    .padding(.horizontal,20)
                    .padding(.vertical,15)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color.pink, Color.blue]), startPoint: .leading, endPoint
                                        
                                        : /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/).clipShape(Capsule())
                        
                    )
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 8, x: 0.0, y: 4.0)
                    
                    List {
                        ForEach(items){item in
                                ListRowItemView(item: item)
                        }
                        .onDelete(perform: deleteItems)
                        
                    }
                    .listStyle(InsetGroupedListStyle())
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.3), radius: 12)
                    .padding(.vertical ,0)
                    .frame(maxWidth: 640)
                }//: VSTACK
                
                if showNewTaskItem{
                    BlankView()
                        .onTapGesture {
                            withAnimation(){
                                showNewTaskItem = false
                            }
                        }
                    NewTaskItemView(isShowinbg: $showNewTaskItem)
                }
            }//: ZSTACK
            .onAppear(){
                UITableView.appearance().backgroundColor = UIColor.clear
            }
            .navigationTitle("Daily Tasks")
            .navigationBarHidden(true)
            .background(BackgroundImage())
            .background(backgroundGradient.ignoresSafeArea(.all))
            
            
        }//: NAVIGATION
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
