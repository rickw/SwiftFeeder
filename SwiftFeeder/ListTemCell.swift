//
//  ListItemCell.swift
//  SwiftFeeder
//
//  Created by Rick Windham on 6/9/15.
//  Copyright (c) 2015 Rick Windham. All rights reserved.
//

import UIKit
import Haneke

class ListItemCell: UITableViewCell {

    
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var favButton: UIButton!
    
    var itemData:ItemModel? {
        didSet {
            if let data = itemData {
                itemImageView.hnk_setImageFromURL(data.smallImageURL, placeholder: nil, format: nil, failure: nil, success: nil)
                
                nameLabel.text = data.name
                categoryLabel.text = data.category
                
                let price:Double = data.price
                
                if price == 0 {
                    priceLabel.text = "FREE!"
                } else {
                    priceLabel.text = String(stringInterpolationSegment: price)
                }

                setFavButtonState(data.favorite)
            }
        }
    }

    //MARK: - layout methods
    
    override class func requiresConstraintBasedLayout() -> Bool {
        return true
    }
    
    //MARK: - lifecycle method
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if let data = itemData {
            setFavButtonState(data.favorite)
        }
    }
    
    override func prepareForReuse() {
        itemData = nil
        itemImageView.hnk_cancelSetImage()
        itemImageView.image = nil
        nameLabel.text = ""
        priceLabel.text = ""
        categoryLabel.text = ""
    }
    
    //MARK: - action methods
    
    @IBAction func favAction(sender: AnyObject) {
        if let data = itemData {
            if data.favorite {
                data.favorite = false
            } else {
                data.favorite = true
            }
            setFavButtonState(data.favorite)
        }
    }

    //MARK: - display methods
    
    func setFavButtonState(favorite:Bool) {
        if favorite {
            favButton.setTitleColor(UIColor.redColor(), forState: .Normal)
        } else {
            favButton.setTitleColor(self.contentView.tintColor, forState: .Normal)
        }
    }
    
    
    
    
    
    
    
}
