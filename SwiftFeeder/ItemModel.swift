//
//  ItemModel.swift
//  SwiftFeeder
//
//  Created by Rick Windham on 6/9/15.
//  Copyright (c) 2015 Rick Windham. All rights reserved.
//

import Foundation

class ItemModel {
    let json:JSON
    var dataSource:ListDataSource
    
    var favorite:Bool {
        get {
            return dataSource.isFavorite(self)
        }
        set(newValue) {
            if newValue != favorite {
                switch newValue {
                case true:
                    self.favorite = dataSource.addFavorite(self)
                case false:
                    self.favorite != dataSource.removeFavorite(self)
                default:
                    break
                }
            }
        }
    }
    
    var smallImageURL:NSURL {
        get {
            return NSURL(string: json["im:image"][0]["label"].stringValue)!
        }
    }
    
    var mediumImageURL:NSURL {
        get {
            return NSURL(string: json["im:image"][1]["label"].stringValue)!
        }
    }
    
    var name:String {
        get {
            return json["im:name"]["label"].stringValue
        }
    }
    
    var category:String {
        get {
            return json["category"]["attributes"]["label"].stringValue
        }
    }
    
    var price:Double {
        get {
            return json["im:price"]["asstributes"]["amount"].doubleValue
        }
    }
    
    var summary:String {
        get {
            return json["summary"]["label"].stringValue
        }
    }
    
    var title:String {
        get {
            return json["title"]["label"].stringValue
        }
    }
    
    var id:String {
        get {
            return json["id"]["attributes"]["im:id"].stringValue
        }
    }
    
    var shareURL:String {
        get {
            return json["id"]["label"].stringValue
        }
    }
    
    init(json:JSON, dataSource:ListDataSource) {
        self.json = json
        self.dataSource = dataSource
    }
}