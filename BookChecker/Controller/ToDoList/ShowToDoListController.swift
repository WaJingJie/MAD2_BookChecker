//
//  ShowToDoListController.swift
//  BookChecker
//
//  Created by MAD2 on 28/1/21.
//

import UIKit

class ShowToDoListController: UITableViewController{
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var itemList:[ItemList] = []
    var contentToSend: ItemList?
    var itemPath:Int!
    let contentController:ContentController = ContentController();
    var refresher = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refresher.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refresher.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        self.tableView.addSubview(refresher)
        let contents = ContentController().retrieveAllContent()
        itemList = contents
        self.tableView.reloadData()
    }
    
    @objc func refresh(_ sender: AnyObject){
        let contents = ContentController().retrieveAllContent()
        itemList = contents
        self.tableView.reloadData()
        refresher.endRefreshing()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let contents = ContentController().retrieveAllContent()
        itemList = contents
        self.tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count
    }
    
    // For inputting each coredata row into tableview row
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "ContentCell", for: indexPath)
        let items = itemList[indexPath.row]
        cell.textLabel!.text = "\(items.listTitle)"
        
        return cell
    }
    
    // Upon Selecting the row will bring the user to a segue
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        contentToSend = itemList[indexPath.row]
        itemPath = indexPath.item
        print("\(contentToSend!.listTitle)")
        
        performSegue(withIdentifier: "contentSegue", sender: contentToSend)
    }
    
    @IBAction func btn_Add(_ sender: Any) {
        performSegue(withIdentifier: "addContentSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ContentViewController, let contentToSend = sender as? ItemList{
            vc.contentView = contentToSend
            vc.itemPath = itemPath
        }
    }
}
