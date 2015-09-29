//
//  ArticleShowViewController.swift
//  itjh_3dTouch
//
//  Created by Songlijun on 15/9/28.
//  Copyright © 2015年 Songlijun. All rights reserved.
//

import UIKit

class ArticleShowViewController: UIViewController {
    
    var urlStr = ""

    @IBOutlet weak var articleWebView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.check3DTouch()

        if urlStr.isEmpty {
            urlStr = "https://github.com"
        }
        
        let url = NSURL(string: urlStr)
        
        let request = NSURLRequest(URL: url!)
        
        articleWebView.loadRequest(request)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
    检测3D Touch
    */
    func check3DTouch() {
        if self.traitCollection.forceTouchCapability != UIForceTouchCapability.Available {
            
            let tap = UITapGestureRecognizer(target: self, action: "dismissMe:")
            self.view.addGestureRecognizer(tap)
            
        }
        
    }
    
    func dismissMe(){
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    

    
    override func previewActionItems() -> [UIPreviewActionItem] {
        
        let action1 = UIPreviewAction(title: "赞", style: .Default) { (_, _) -> Void in
            
            print("点击了赞")
            
        }
        
        let action2 = UIPreviewAction(title: "分享", style: .Default) { (_, _) -> Void in
            
            print("点击了分享")
            
        }
        
        let actions = [action1,action2]
        
        return actions
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
