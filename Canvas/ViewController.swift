//
//  ViewController.swift
//  Canvas
//
//  Created by Matthew Goo on 10/7/15.
//  Copyright © 2015 mattgoo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var trayView: UIView!
    var trayOriginalCenter: CGPoint?
    var trayCenterWhenOpen: CGPoint?
    var trayCenterWhenClosed: CGPoint?
    var newlyCreatedFace: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let x = trayView.center.x
        let yOpen = trayView.center.y
        let yClose = (self.view.frame.height + 65)
        print(yClose)
        trayCenterWhenOpen = CGPoint(x: x, y: yOpen)
        trayCenterWhenClosed = CGPoint(x: x, y: yClose)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func panGesture(panGestureRecognizer: UIPanGestureRecognizer) {
        let point = panGestureRecognizer.locationInView(self.view)
        
        if panGestureRecognizer.state == UIGestureRecognizerState.Began {
            trayOriginalCenter = trayView.center
            print("Gesture began at: \(point)")
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Changed {
            let translation = panGestureRecognizer.translationInView(self.view)
            trayView.center = CGPoint(x: trayOriginalCenter!.x,
                y: trayOriginalCenter!.y + translation.y)
            print("Gesture changed at: \(point)")
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Ended {
            let velocity = panGestureRecognizer.velocityInView(self.view)
            if velocity.y > 0 {
                UIView.animateWithDuration(1.0, animations: { () -> Void in
                    self.trayView.center = self.trayCenterWhenClosed!
                })
            } else {
                UIView.animateWithDuration(1.0, animations: { () -> Void in
                    self.trayView.center = self.trayCenterWhenOpen!
                })
            }
            print("Gesture ended at: \(point)")
        }
    }

    @IBAction func panSmiley(panGestureRecognizer: UIPanGestureRecognizer) {
        let point = panGestureRecognizer.locationInView(self.view)
        
        if panGestureRecognizer.state == UIGestureRecognizerState.Began {
            let imageView = panGestureRecognizer.view as! UIImageView
            
            // Create a new image view that has the same image as the one currently panning
            newlyCreatedFace = UIImageView(image: imageView.image)
            
            // Add the new face to the tray's parent view.
            view.addSubview(newlyCreatedFace)
            
            // Initialize the position of the new face.
            newlyCreatedFace.center = imageView.center
            
            // Since the original face is in the tray, but the new face is in the
            // main view, you have to offset the coordinates
            newlyCreatedFace.center.y += trayView.frame.origin.y
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Changed {
            newlyCreatedFace.center = point
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Ended {
            
        }
    }
}

