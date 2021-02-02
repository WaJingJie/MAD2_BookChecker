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
    
    @IBOutlet weak var urlLink: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //code to enter get the pdf file from local storage and store it into the coredata  
    @IBAction func importPDF(_ sender: Any) {
         let documentPicker = UIDocumentPickerViewController(documentTypes: [kUTTypeCompositeContent as String], in: .import)
         documentPicker.delegate = self
         
         //allow only 1 pdf file to be pick
         documentPicker.allowsMultipleSelection = false
             
         present(documentPicker, animated: true, completion: nil)
     }
    
    //code to enter the pdf url into the coredata
    @IBAction func importUrl(_ sender: Any) {
        if(urlLink.text != ""){
            guard let url = URL(string: urlLink.text! )else{return}
            
            let urlSesson = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue())
            
            let downloadTask = urlSesson.downloadTask(with: url)
            downloadTask.resume()
        }
        else{
            print("Please enter a link")
        }
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
            let alertView = UIAlertController(title: "Invalid", message: "PDF is already imported", preferredStyle: UIAlertController.Style.alert)
            
            alertView.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            DispatchQueue.main.async(execute: {()-> Void in
                self.present(alertView, animated: true, completion: nil)
            })
            print(selectedFileUrl.lastPathComponent)

        } else{
            do{
                
                try FileManager.default.copyItem(at: selectedFileUrl, to: sandboxFileUrl)
                
                bookController.Add(newContent: BookList(booktitle: (selectedFileUrl.lastPathComponent as String?)!))
                
            } catch{
                print("Error \(error)")
            }
        }
    }
}

extension AddBookController: URLSessionDownloadDelegate{
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("downloadlication:", location)
        
        //save to local storage
        guard let url = downloadTask.originalRequest?.url else {return}
        
        //get the path of the document folder in the local storage
        let docpath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        if(url.lastPathComponent.suffix(4) == ".pdf"){
            //save the downloaded file into the project's sandbox
            let destinationPath = docpath.appendingPathComponent(url.lastPathComponent)
            
            //prevent dup pdf
            if FileManager.default.fileExists(atPath: destinationPath.path){
                let alertView = UIAlertController(title: "Invalid", message: "PDF is already imported", preferredStyle: UIAlertController.Style.alert)
                
                alertView.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                DispatchQueue.main.async(execute: {()-> Void in
                    self.present(alertView, animated: true, completion: nil)
                })
                
                print(destinationPath.lastPathComponent)

            } else{
                do{
                    
                    try FileManager.default.copyItem(at: location, to: destinationPath)
                    print("Imported pdf file")
                    
                    bookController.Add(newContent: BookList(booktitle: (destinationPath.lastPathComponent as String?)!))
                    
                } catch{
                    print("Error \(error)")
                }
            }
        }
        else if (url.lastPathComponent.suffix(4) != ".pdf"){
            //alert user when pdf url is incorrect
            let alertView = UIAlertController(title: "Invalid", message: "Website link must end with .pdf", preferredStyle: UIAlertController.Style.alert)
            
            alertView.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            DispatchQueue.main.async(execute: {()-> Void in
                self.present(alertView, animated: true, completion: nil)
            })
            
        }
    }
}
