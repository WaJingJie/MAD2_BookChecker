//
//  ShowBookListController.swift
//  BookChecker
//
//  Created by MAD2 on 28/1/21.
//

import UIKit

class ShowBookListController: UITableViewController{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var bookList:[BookList] = []
    var contentToSend: BookList?
    var itemPath:Int!
    let bookController:BookController = BookController();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.reloadData()
        let contents = BookController().retrieveAllContent()
        bookList = contents
        self.tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "ContentCell", for: indexPath)
        let items = bookList[indexPath.row]
        cell.textLabel!.text = "\(items.bookTitle)"
    
        return cell
    }
    
    // clickable sections
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        contentToSend = bookList[indexPath.row]
        itemPath = indexPath.item
        print("\(contentToSend!.bookTitle)")
        
        performSegue(withIdentifier: "contentSegue", sender: contentToSend)
    }
    
    @IBAction func btn_Add(_ sender: Any) {
        performSegue(withIdentifier: "addContentSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ShowPDFViewController, let contentToSend = sender as? BookList{
            vc.contentView = contentToSend
            vc.itemPath = itemPath
        }
    }

}
