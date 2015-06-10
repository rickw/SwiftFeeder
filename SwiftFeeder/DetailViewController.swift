//
//  DetailViewController.swift
//  SwiftFeeder
//
//  Created by Rick Windham on 6/9/15.
//  Copyright (c) 2015 Rick Windham. All rights reserved.
//

import UIKit
import Haneke

class DetailViewController: UIViewController {
    
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var summeryTextView: UITextView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var favButton: UIButton!

    var detailData:ItemModel?
    var dataSource:ListDataSource?
    
    //MARK: - lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        if let data = detailData {
            itemImageView.hnk_setImageFromURL(data.mediumImageURL, placeholder: nil, format: nil, failure: nil) { image in
                dispatch_async(dispatch_get_main_queue()) {
                    self.itemImageView.image = image
                }
            }
            summeryTextView.text = data.summary
            titleLabel.text = data.title
            summeryTextView.scrollRangeToVisible(NSRange(location: 0,length: 0))
            setFavButtonState(data.favorite)
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - display methods
    
    func setFavButtonState(favorite:Bool) {
        if favorite {
            favButton.setTitleColor(UIColor.redColor(), forState: .Normal)
        } else {
            favButton.setTitleColor(self.view.tintColor, forState: .Normal)
        }
    }

    //MARK: - action methods

    @IBAction func favAction(sender: AnyObject) {
        if let data = detailData {
            if data.favorite {
                data.favorite = false
            } else {
                data.favorite = true
            }
            setFavButtonState(data.favorite)
        }
    }
    
    @IBAction func backAction(sender: AnyObject) {
        if let presenting = self.presentingViewController as? ViewController {
            presenting.tableView.reloadData()
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
   
    @IBAction func shareAction(sender: AnyObject) {
        if let data = self.detailData {
        let activityViewController = UIActivityViewController(activityItems: [data.title, data.shareURL], applicationActivities: nil)
        activityViewController.excludedActivityTypes =  [
            UIActivityTypePostToFacebook,
            UIActivityTypePostToWeibo,
            UIActivityTypeMessage,
            UIActivityTypePrint,
            UIActivityTypeAssignToContact,
            UIActivityTypeSaveToCameraRoll,
            UIActivityTypeAddToReadingList,
            UIActivityTypePostToFlickr,
            UIActivityTypePostToVimeo,
            UIActivityTypePostToTencentWeibo
        ]
        
        self.presentViewController(activityViewController, animated: true, completion: nil)
        }
    }
}
