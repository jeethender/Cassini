//
//  CassiniViewController.swift
//  Cassini
//
//  Created by maisapride8 on 27/05/16.
//  Copyright © 2016 maisapride8. All rights reserved.
//

import UIKit

class CassiniViewController: UIViewController, UISplitViewControllerDelegate
{

    private struct Storyboard {
       static let  showImageSegue = "Show Image"
        
    }

   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
    if segue.identifier == Storyboard.showImageSegue {
        if let ivc = segue.destinationViewController.contentViewController as? ImageViewController {
            let imageName = (sender as? UIButton)?.currentTitle
            ivc.imageURL = DemoURL.NASAImageNamed(imageName)
            ivc.title = imageName
            
        }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        splitViewController?.delegate = self
    }
    func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController: UIViewController, ontoPrimaryViewController primaryViewController: UIViewController) -> Bool {
        if primaryViewController.contentViewController == self {
            if let ivc = secondaryViewController.contentViewController as? ImageViewController where ivc.imageURL == nil {
                return true
            }
        }
        return false
    }
    
    @IBAction func showImage(sender: UIButton) {
        if let ivc = splitViewController?.viewControllers.last?.contentViewController as? ImageViewController {
            let imageName = sender.currentTitle
            ivc.imageURL = DemoURL.NASAImageNamed(imageName)
            ivc.title = imageName
        } else {
            performSegueWithIdentifier(Storyboard.showImageSegue, sender: sender)
        }
        
    }
}





extension UIViewController {
    
    var contentViewController: UIViewController {
        
        if let navcon = self as? UINavigationController {
            
         return navcon.visibleViewController ?? self
        } else {
            return self
        }
    }
}