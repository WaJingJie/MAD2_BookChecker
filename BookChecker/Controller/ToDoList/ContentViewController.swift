//
//  ContentViewController.swift
//  BookChecker
//
//  Created by MAD2 on 31/1/21.
//

import UIKit
import CoreData

class ContentViewController: UIViewController{
    
    var contentView:ItemList?
    var content:ItemList?
    var itemPath:Int!
    var contentController:ContentController = ContentController()
    
    @IBOutlet weak var txt_Title: UITextField!
    @IBOutlet weak var txt_Content: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Testing: \(itemPath!)");
        txt_Title.text = contentView?.listTitle
        txt_Content.text = contentView?.listContent
    }
    
    @IBAction func btn_Edit(_ sender: Any) {
        if(txt_Title.text != ""){
            let c:ItemList = ItemList(listtitle: txt_Title.text!, listcontent: txt_Content.text!)
            contentController.updateContent(index: itemPath, newItem: c)
        }else{
            let c:ItemList = ItemList(listtitle: "No Title", listcontent: txt_Content.text!)
            contentController.updateContent(index: itemPath, newItem: c)
        }
        endSession()
    }
    
    @IBAction func btn_Delete(_ sender: Any) {
        contentController.deleteContent(index: itemPath)
        endSession()
    }
    
    func endSession() {
        self.dismiss(animated: true) {
            print("Back to main controller")
        }
    }
}
