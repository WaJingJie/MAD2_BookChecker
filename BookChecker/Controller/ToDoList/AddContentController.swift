//
//  AddContentController.swift
//  BookChecker
//
//  Created by MAD2 on 30/1/21.
//

import UIKit

class AddContentController: UIViewController{
    
    @IBOutlet weak var txt_Title: UITextField!
    @IBOutlet weak var txt_Content: UITextView!
    
    var itemList:ItemList?
    let contentController:ContentController = ContentController();
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btn_AddContent(_ sender: Any) {
        if(txt_Title.text != ""){
            if(txt_Content.text != ""){
                contentController.Add(newContent: ItemList(listtitle: txt_Title.text!, listcontent: txt_Content.text!))
            }else{
                contentController.Add(newContent: ItemList(listtitle: txt_Title.text!, listcontent: ""))
            }
        }
        
        txt_Title.text = ""
        txt_Content.text = ""
    }
}
