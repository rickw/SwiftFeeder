//
//  ListDataSource.swift
//  SwiftFeeder
//
//  Created by Rick Windham on 6/9/15.
//  Copyright (c) 2015 Rick Windham. All rights reserved.
//

import UIKit
import CoreData

typealias FetchCompleteBlock = (Int)->()

@objc class ListDataSource: NSObject, UITableViewDataSource {
    let coreDataFun = CoreDataFun(context: (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!)
    
    var listJSON:JSON?
    var error:NSError?
    var block:FetchCompleteBlock?
    
    var items = [ItemModel]()
    
    let url:NSURL = NSURL(string: "https://itunes.apple.com/us/rss/topgrossingapplications/limit=50/json")!
    let session = NSURLSession.sharedSession()
    var dataTask:NSURLSessionTask?
    
    var itemCount:Int {
        get {
            return self.items.count
        }
    }
    
    //MARK: - lifecycle methods
    
    init(block:FetchCompleteBlock) {
        super.init()
        
        self.block = block
        
        self.dataTask  = self.session.dataTaskWithURL(url, completionHandler: {[weak self] data, response, error -> Void in
            if let sSelf = self {
                if let err = error {
                    sSelf.error = err
                    NSLog("error fetching data: \(err)")
                }

                sSelf.listJSON = JSON(data: data)["feed"]["entry"]
                
                sSelf.items.removeAll(keepCapacity: true)

                if let list = sSelf.listJSON {
                    for item in list.arrayValue {
                        let newItem = ItemModel(json: item, dataSource: sSelf)
                        
                        sSelf.items.append(newItem)
                    }
                }
                
                if let block = sSelf.block {
                    dispatch_async(dispatch_get_main_queue()) { block(sSelf.itemCount) }
                }
            }
        })
        self.dataTask!.resume()
    }
    
    //MARK: - logic methods
    
    func isFavorite(item:ItemModel) -> Bool {
        if let fav = getFavoriteObject(item) {
            return true
        }
        return false
    }
    
    func getFavoriteObject(item:ItemModel) -> Favorite? {
        let result = coreDataFun.fetchWhere("id", equals: item.id, forEntityName: Favorite.entityName()) as [AnyObject]?
        
        if let res = result {
            if res.count > 0 {
                return res[0] as? Favorite
            }
        }
        
        return nil
    }
    
    func addFavorite(item:ItemModel) -> Bool {
        if isFavorite(item) == false {
            let newFav:Favorite = Favorite(managedObjectContext: coreDataFun.moc)
            newFav.id = item.id
            
            if coreDataFun.saveAction() {
                return true
            }
        }
        
        return false
    }
    
    func removeFavorite(item:ItemModel) -> Bool {
        if let fav = getFavoriteObject(item) {
            coreDataFun.moc.deleteObject(fav)
            
            if coreDataFun.saveAction() {
                return true
            }
        }
        
        return false
    }
    
    //MARK: - dataSource methods
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    @objc func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemCount
    }
    
    @objc func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:ListItemCell = tableView.dequeueReusableCellWithIdentifier("ListItemCell", forIndexPath: indexPath) as! ListItemCell
        cell.itemData = items[indexPath.row]
        
        return cell
    }
}