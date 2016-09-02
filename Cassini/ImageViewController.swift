//
//  ViewController.swift
//  Cassini
//
//  Created by maisapride8 on 26/05/16.
//  Copyright © 2016 maisapride8. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate
{
    var imageURL:NSURL?{
        didSet{
            image = nil
            if view.window != nil {
            fetchImage()
            }
        }
    }
    private func fetchImage(){
        if let url = imageURL{
            spinner?.startAnimating()
            dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)){
                
                let contentsOfURL =  NSData(contentsOfURL: url)
                
                dispatch_async(dispatch_get_main_queue()) {
                    if url == self.imageURL{
                    if let imageData = contentsOfURL {
                        self.image = UIImage(data: imageData)
                    }else{
                        self.spinner?.stopAnimating()
                        }
                    } else {
                        print("ignored data returned fron url \(url)")
                    }
                }
            }
        }
    }
    
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet{
            scrollView?.contentSize = imageView.frame.size
            scrollView.delegate = self
            scrollView.minimumZoomScale = 0.03
            scrollView.maximumZoomScale = 1.0
        }
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    private var imageView = UIImageView()
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    private var  image: UIImage? {
        get{
            return imageView.image
        }
        
        set{
            imageView.image = newValue
            imageView.sizeToFit()
            scrollView?.contentSize = imageView.frame.size
            spinner?.stopAnimating()
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if image == nil {
            fetchImage()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.addSubview(imageView)
        //imageURL = NSURL(string: DemoURL.Stanford)
        
    }
    
}

