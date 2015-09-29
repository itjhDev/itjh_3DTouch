//
//  ArticlesTableViewController.swift
//  itjh_3dTouch
//
//  Created by Songlijun on 15/9/28.
//  Copyright © 2015年 Songlijun. All rights reserved.
//

import UIKit



class ArticlesTableViewController: UITableViewController,UIViewControllerPreviewingDelegate {
    
//    UILongPressGestureRecognizer *longPress;
    
    // 长按手势
    var longPress = UILongPressGestureRecognizer()
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
  
    
    
    override func viewWillAppear(animated: Bool) {
        //检测3D Touch
        
        check3DTouch()
        
    }
    
    /**
    检测页面是否处于3DTouch
    */
    func check3DTouch(){
        
        if self.traitCollection.forceTouchCapability == UIForceTouchCapability.Available {
            
            self.registerForPreviewingWithDelegate(self, sourceView: self.view)
            print("3D Touch 开启")
            //长按停止
            self.longPress.enabled = false
            
        } else {
            print("3D Touch 没有开启")
            self.longPress.enabled = true
        }
    }
 
    
    // MARK: 3D Touch Delegate
    
    /**
    轻按进入浮动页面
    
    - parameter previewingContext: previewingContext description
    - parameter location:          location description
    
    - returns: 文章详情页  浮动页
    */
    func previewingContext(previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
   
        
        let cellPosition = tableView.convertPoint(location, fromView: view)
        
        if let touchedIndexPath = tableView.indexPathForRowAtPoint(cellPosition) {
            
            tableView.deselectRowAtIndexPath(touchedIndexPath, animated: true)
            
            let aStoryboard = UIStoryboard(name: "Main", bundle:NSBundle.mainBundle())
            
            if let myVC = aStoryboard.instantiateViewControllerWithIdentifier("ArtilceShowView") as? ArticleShowViewController  {
                
                myVC.urlStr = "https://www.baidu.com"
                
                let cellFrame = tableView.cellForRowAtIndexPath(touchedIndexPath)!.frame
                previewingContext.sourceRect = view.convertRect(cellFrame, fromView: tableView)
                
                
                
                return myVC  
            }  
        }
        
        return UIViewController()
    }
    
        
    /**
    重按进入文章详情页
    
    - parameter previewingContext:      previewingContext description
    - parameter viewControllerToCommit: viewControllerToCommit description
    */
    func previewingContext(previewingContext: UIViewControllerPreviewing, commitViewController viewControllerToCommit: UIViewController) {
        let stotyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let articleShowController = stotyboard.instantiateViewControllerWithIdentifier("ArtilceShowView") as! ArticleShowViewController
     
        articleShowController.urlStr = "https://www.baidu.com"
        
        self.showViewController(articleShowController, sender: self)
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10
    }

   
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ArticleCell", forIndexPath: indexPath) as! ArticleTableViewCell
        
        cell.title.text = "IT江湖,每一个IT人的江湖\(indexPath.row)"

        // Configure the cell...

        return cell
    }
  
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        print("点击了\(indexPath.row)")
        
        check3DTouch()
        
    }
    
    
    //MARK: 3D Touch Alternative
    
    /**
    显示Peek
    */
    func showPeek(){
        
        self.longPress.enabled = false
        let stotyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let articleShowController = stotyboard.instantiateViewControllerWithIdentifier("ArtilceShowView") as! ArticleShowViewController
     
        let article = self.grabTopViewController()
        
        article.showViewController(articleShowController, sender: self)
        
    }
    
    
    /**
    3D Touch top滑动
    
    - returns: top页面
    */
    func grabTopViewController() -> UIViewController {
        
        var top = UIApplication.sharedApplication().keyWindow?.rootViewController
        
        while (top!.presentedViewController != nil) {
            top = top!.presentedViewController
        }
        
        return top!
    }
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//   
//        if segue.identifier == "toArticleShow" {
//            check3DTouch()
//        }
//        
//    }


}
