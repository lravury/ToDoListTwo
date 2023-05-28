//
//  ToDoItem.swift
//  ToDoList
//
//  Created by Lauren Ravury on 5/24/23.
//

import Foundation

class ToDoItem: Identifiable {
    
    var id = UUID()
    var title = "";
    var isImportant = false;
    
    init(title: String, isImportant: Bool = false) {
        self.title = title;
        self.isImportant = isImportant;
    }
}
