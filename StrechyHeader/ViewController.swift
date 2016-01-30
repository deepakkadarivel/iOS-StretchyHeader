//
//  ViewController.swift
//  StrechyHeader
//
//  Created by Deepak Kadarivel on 30/01/16.
//  Copyright © 2016 upbeatios. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    //Step 1: Create a imageview reference for tableview to hold the image
    var imageView = UIImageView()
    
    //Step 2: Set the factor for parallelxeffect, it is a float value and can be overwritable
    var parallexFactor: CGFloat = 2.0
    
    //Step 3: set the default height for the image on top
    var imageHeight: CGFloat = 300.0 {
        didSet {
            moveImage()
        }
    }
    
    //Step 4 : Initialize the scrollOffset variable
    var scrollOffset: CGFloat = 0 {
        didSet {
            moveImage()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addGradientBackground()
        
        self.imageView.image = UIImage(named: "image.png")
        
        //Step 5: Set Content Inset for tableview to hold image on top
        self.tableView.contentInset = UIEdgeInsets(top: imageHeight, left: 0, bottom: 0, right: 0)
        
        //Step 6: Change the content mode og imageview
        self.imageView.contentMode = .ScaleAspectFill
        
        //Step 7: add imageview to tableview and send it to back
        self.tableView.addSubview(imageView)
        self.tableView.sendSubviewToBack(imageView)
        
        tableView.tableFooterView = UIView(frame: CGRectZero)
    }
    
    //step 8: Define method for image location changes
    func moveImage() {
        let imageOffset = (scrollOffset > 0) ? scrollOffset / parallexFactor : 0
        let imageHeight = (scrollOffset > 0) ? self.imageHeight : self.imageHeight - scrollOffset
        self.imageView.frame = CGRect(x: 0, y: -imageHeight + imageOffset, width: view.bounds.size.width, height: imageHeight)
    }
    
    //Step 9 : update image position after layout changes
    override func viewDidLayoutSubviews() {
        moveImage()
    }
    
    //step 10: update scrolloffset on tableview scroll
    func scrollViewDidScroll(scrollView: UIScrollView) {
        scrollOffset = tableView.contentOffset.y + imageHeight
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell

        return cell
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .Default
    }
    
    func addGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.frame
        
        let colorTop: AnyObject = UIColor(red: 200.0/255.0, green: 204.0/255.0, blue: 208.0/255.0, alpha: 1.0).CGColor
        let colorBottom: AnyObject = UIColor(red: 197.0/255.0, green: 166.0/255.0, blue: 129.0/255, alpha: 1.0).CGColor
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        
        view.layer.insertSublayer(gradientLayer, atIndex: 0)
    }

}

