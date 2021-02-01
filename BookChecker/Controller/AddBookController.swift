//
//  AddBookController.swift
//  BookChecker
//
//  Created by MAD2 on 28/1/21.
//

import UIKit
import MobileCoreServices

class AddBookController: UIViewController{
    var bookList:BookList?
    let bookController:BookController = BookController();
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func importPDF(_ sender: Any) {
         let documentPicker = UIDocumentPickerViewController(documentTypes: [kUTTypeCompositeContent as String], in: .import)
         documentPicker.delegate = self
         
         //allow only 1 pdf file to be pick
         documentPicker.allowsMultipleSelection = false
             
         present(documentPicker, animated: true, completion: nil)
     }
}

extension AddBookController: UIDocumentPickerDelegate{
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let selectedFileUrl = urls.first else{
            return
        }
        
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        let sandboxFileUrl = dir.appendingPathComponent(selectedFileUrl.lastPathComponent)
        
        if FileManager.default.fileExists(atPath: sandboxFileUrl.path){
            print("Already imported!")
            print(selectedFileUrl.lastPathComponent)

        } else{
            do{
                
                try FileManager.default.copyItem(at: selectedFileUrl, to: sandboxFileUrl)
                print("Imported pdf file")
                
                bookController.Add(newContent: BookList(booktitle: (selectedFileUrl.lastPathComponent as String?)!))
                
            } catch{
                print("Error \(error)")
            }
        }
    }
}
