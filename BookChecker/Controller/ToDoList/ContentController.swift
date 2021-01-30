//
//  ContentController.swift
//  BookChecker
//
//  Created by MAD2 on 30/1/21.
//

import UIKit
import CoreData

class ContentController{
    func Add(newContent:ItemList){
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "CDToDoList", in: context)!
        
        let content = NSManagedObject(entity: entity, insertInto: context)
        content.setValue(newContent.listTitle, forKey: "title")
        content.setValue(newContent.listContent, forKey: "content")
        
        do{
            try context.save()
        }catch let error as NSError{
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func retrieveAllContent()->[ItemList]{
        var contents:[NSManagedObject] = []
        var allContents:[ItemList] = []
        
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CDToDoList")
        do{
            contents = try context.fetch(fetchRequest)
            for c in contents{
                let title = c.value(forKeyPath: "title") as? String
                let content = c.value(forKeyPath: "content") as? String
                print("\(title!)")
                
                let newContents:ItemList = ItemList(listtitle: title!, listcontent: content!)
                
                allContents.append(newContents)
            }
            
        }catch let error as NSError{
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return allContents
    }
}
