//
//  ContentView.swift
//  WishList
//
//  Created by Wajd on 17/08/2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    //#5
    @Environment(\.modelContext) private var modelContext
    //#6
    @Query private var Wishes: [Wish]
    
    @State private var isAlertShowing: Bool = false
    
    @State private var title: String = ""
    
    var body: some View {
        NavigationStack{
            List{
                ForEach(Wishes){ wish in
                    Text(wish.title)
                        .font(.title)
                        .fontWeight(.light)
                        .padding(.vertical, 2)
                        .swipeActions(){
                            Button("Delete", role: .destructive) {
                                modelContext.delete(wish)
                            }
                        }
                }
            }//List
            .navigationTitle("WishList")
            .toolbar{
                ToolbarItem(placement: .topBarTrailing){
                    Button{
                        isAlertShowing.toggle()
                    }label: {
                        Image(systemName: "plus")
                        //Spacer()
                    }
                }
                
                if Wishes.isEmpty != true {
                    ToolbarItem(placement: .bottomBar){
                        Text("\(Wishes.count) wish")
                    }
                }
            }
            
            .alert("Create a new wish", isPresented: $isAlertShowing) {
                TextField("write your wish", text: $title)
                
                Button{
                    modelContext.insert(Wish(title:title))
                    title = ""
                }label: {
                    Text("Save")
                }
            }
            
            //overlay add a layer over the view that doesn't impact the actual view
            .overlay{
                if Wishes.isEmpty{
                    ContentUnavailableView("My WishList", systemImage: "heart.circle", description: Text("No wishes yet"))
                }
            }
        }
    }
}

extension ContentView {
    /// ينشئ كونتينر In-Memory ويعبّيه بيانات تجريبية
    static func makePreviewContainer() -> ModelContainer {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: Wish.self, configurations: config)
        let ctx = container.mainContext
        ctx.insert(Wish(title: "Master SwiftData"))
        ctx.insert(Wish(title: "Buy new iPhone"))
        ctx.insert(Wish(title: "Practice latin dances"))
        ctx.insert(Wish(title: "Practice IELTS test"))
        return container
    }
}

#Preview("List with Sample Data") {
    ContentView()
        .modelContainer(ContentView.makePreviewContainer())
}

#Preview("Empty List") {
    ContentView()
        .modelContainer(for: Wish.self, inMemory: true)
}
