//
//  ViewController.swift
//  BusinessInfoApp
//
//  Created by Mathias Møller Feldt on 07/02/2020.
//  Copyright © 2020 Mathias Møller. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var backgroundView: UIImageView!
    @IBOutlet weak var legoBlocksView: UIImageView!
    @IBOutlet weak var logoView: UIImageView!
    @IBOutlet weak var textView: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        slideInAnimation(duration: 1.0, delay: 1.5, uiim: legoBlocksView)
        slideInAnimation(duration: 1.0, delay: 1.0, uiim: logoView)
        changeBackgroundColor(duration: 5, uiiv: backgroundView)
        slideInAnimation(duration: 2.0, delay: 1.5, uil: textView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    //Function for slide in an object
    func slideInAnimation(duration: TimeInterval, delay: TimeInterval, uiim: UIImageView ){
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseOut, animations: {
          var frame = uiim.frame
          frame.origin.y -= frame.size.height
          
          uiim.frame = frame
        
        }, completion: { finished in
          print("Frame is in view")
        })
    }
    
    func slideInAnimation(duration: TimeInterval, delay: TimeInterval, uil: UILabel ){
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseOut, animations: {
          var frame = uil.frame
          frame.origin.y -= frame.size.height
          
          uil.frame = frame
        
        }, completion: { finished in
          print("Frame is in view")
        })
    }
    
    func changeBackgroundColor(duration: TimeInterval, uiiv: UIImageView){
        UIView.animate(withDuration: duration) {
            uiiv.backgroundColor = UIColor(red:0.85, green:0.04, blue:0.00, alpha:1.0)
        }
    }
    
    
}

