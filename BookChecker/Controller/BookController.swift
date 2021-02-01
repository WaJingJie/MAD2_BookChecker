//
//  BookController.swift
//  BookChecker
//
//  Created by MAD2 on 2/2/21.
//

import Foundation
import UIKit
import CoreData

class BookController{
    
    var appDelegate:AppDelegate
    let context:NSManagedObjectContext

    init() {
        appDelegate  = (UIApplication.shared.delegate) as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
    }
    
    func Add(newContent:BookList){
        let entity = NSEntityDescription.entity(forEntityName: "CDBookList", in: context)!
        
        let content = NSManagedObject(entity: entity, insertInto: context)
        content.setValue(newContent.bookTitle, forKey: "booktitle")
        
        do{
            try context.save()
        }catch let error as NSError{
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func retrieveAllContent()->[BookList]{
        var contents:[NSManagedObject] = []
        var allContents:[BookList] = []
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CDBookList")
        do{
            contents = try context.fetch(fetchRequest)
            for c in contents{
                let title = c.value(forKeyPath: "booktitle") as? String
                
                let newContents:BookList = BookList(booktitle: title!)
                
                allContents.append(newContents)
            }
            
        }catch let error as NSError{
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return allContents
    }
    
    func updateContent(index:Int, newItem:BookList){
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "CDBookList")
        
        do {
            let result = try context.fetch(fetchRequest)
            
            let contentUpdate = result[index] as! NSManagedObject
            contentUpdate.setValue(newItem.bookTitle, forKey: "booktitle")
            
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
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDBookList")
        
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
