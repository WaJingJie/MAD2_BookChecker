//
//  ContentController.swift
//  BookChecker
//
//  Created by MAD2 on 30/1/21.
//

import UIKit
import CoreData

class ContentController{
    
    var appDelegate:AppDelegate
    let context:NSManagedObjectContext
    
    //Initialize Variables
    init() {
        appDelegate  = (UIApplication.shared.delegate) as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
    }
    
    //To Add a New Content
    func Add(newContent:ItemList){
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
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CDToDoList")
        do{
            contents = try context.fetch(fetchRequest)
            for c in contents{
                let title = c.value(forKeyPath: "title") as? String
                let content = c.value(forKeyPath: "content") as? String
                
                let newContents:ItemList = ItemList(listtitle: title!, listcontent: content!)
                
                allContents.append(newContents)
            }
            
        }catch let error as NSError{
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return allContents
    }
    
    func updateContent(index:Int, newItem:ItemList){
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "CDToDoList")
        
        do {
            let result = try context.fetch(fetchRequest)
            
            let contentUpdate = result[index] as! NSManagedObject
            contentUpdate.setValue(newItem.listTitle, forKey: "title")
            contentUpdate.setValue(newItem.listContent, forKey: "content")
            
            do {
                try context.save()
            } catch  {
                print(error)
            }
            
        } catch  {
            print(error)
        }
    }
    
    func deleteContent(index:Int){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDToDoList")
        
        do {
            let result = try context.fetch(fetchRequest)
            
            let contentToDelete = result[index] as! NSManagedObject
            context.delete(contentToDelete)
            
            do {
                try context.save()
            } catch  {
                print(error)
            }
            
        } catch  {
            print(error)
        }
    }
}
