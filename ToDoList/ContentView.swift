//
//  ContentView.swift
//  ToDoList
//
//  Created by Lauren Ravury on 5/24/23.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var context
    @State private var showNewTask = false
    @FetchRequest(
            entity: ToDo.entity(), sortDescriptors: [ NSSortDescriptor(keyPath: \ToDo.id, ascending: false) ])
        
    var toDoItems: FetchedResults<ToDo>
    var body: some View {
        VStack {
            HStack {
                
                Text("To Do List")
                    .font(.system(size: 30))
                Spacer()
                
                Button(action: {
                    self.showNewTask = true
                }) {
                    Text("+")
                }
                
                
            }
            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
           Spacer()
            
            List {
                ForEach (toDoItems) {
                    toDoItem in
                    
                    if toDoItem.isImportant {
                        Text("❗️" + (toDoItem.title ?? "no title") + "❗️")
                        
                    } else {
                        Text(toDoItem.title ?? "no title")
                    }
                    
                }
                .onDelete(perform: deleteTask)
            }
            .listStyle(.plain)
            
        }
        
        if showNewTask {
            NewToDoView(title: "", isImportant: false, showNewTask: $showNewTask)
            
        }
    }
    private func deleteTask(offsets: IndexSet) {
            withAnimation {
                offsets.map { toDoItems[$0] }.forEach(context.delete)

                do {
                    try context.save()
                } catch {
                    print(error)
                }
            }
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
