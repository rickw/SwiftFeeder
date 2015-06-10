//
//  ViewController.swift
//  SwiftFeeder
//
//  Created by Rick Windham on 6/9/15.
//  Copyright (c) 2015 Rick Windham. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    
    
    var dataSource:ListDataSource! = nil
    
    //MARK: -- lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.dataSource = ListDataSource() {[weak self] count in
            if let sSelf = self {
                sSelf.tableView.reloadData()
            }
        }
        self.tableView.dataSource = self.dataSource
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: - delegate methods
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let detailController:DetailViewController = segue.destinationViewController as! DetailViewController
        detailController.detailData = (self.tableView.cellForRowAtIndexPath(self.tableView.indexPathForSelectedRow()!) as! ListItemCell).itemData
        detailController.dataSource = self.dataSource
    }

}

