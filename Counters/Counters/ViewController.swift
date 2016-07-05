//
//  ViewController.swift
//  Counters
//
//  Created by Mike Camara on 4/12/2015.
//  Copyright © 2015 Mike Camara. All rights reserved.
//

import UIKit
import AVFoundation
import AudioToolbox

class ViewController: UIViewController {
    
    // Properties
    var counter = 0
    var capacityForPlacesLeft = 0
    var initialCapacity = 20
    var capacity = 0
    
    // Outlets
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var placesLeftCounter: UILabel!
    @IBOutlet weak var capacityButton: UIButton!
    @IBOutlet weak var capacityNumberLabel: UILabel!
    @IBOutlet weak var reduceButtonOutlet: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        capacity = initialCapacity
        capacityButton.setTitle(String(initialCapacity), forState: .Normal)
        countLabel.text = String(counter)
        placesLeftCounter.text = String(capacity)
        
        // Status bar color white
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        
        // Swipw recogniser code
        
        var swipeRight = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(swipeRight)
        
        var swipeDown = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeDown.direction = UISwipeGestureRecognizerDirection.Down
        self.view.addGestureRecognizer(swipeDown)
        
        
    }
    
    // Swipe gesture function
    
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.Right:
                print("Swiped right")
            case UISwipeGestureRecognizerDirection.Down:
                print("Swiped down")
                decrement()
            case UISwipeGestureRecognizerDirection.Left:
                print("Swiped left")
            case UISwipeGestureRecognizerDirection.Up:
                print("Swiped up")
            default:
                break
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkCapacity(){
        if counter > capacity {
            countLabel.textColor = UIColor.redColor()
        }else{
            countLabel.textColor = UIColor.cyanColor()
            
        }
    }
    
    func updatePlacesLeft(){
        
        var capacityForPlacesLeft = capacity
        
        capacityForPlacesLeft = capacity - counter
        placesLeftCounter.text = String(capacityForPlacesLeft)
        
    }
    
    @IBAction func capacityButtonAction(sender: AnyObject) {
        
        let ac = UIAlertController(title: "Capacity", message: nil, preferredStyle: .Alert)
        
        // Have a numberpad in a textfield of an alert controller
        ac.addTextFieldWithConfigurationHandler{ (textField: UITextField!) in
            textField.keyboardType = UIKeyboardType.NumberPad
        }
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        
        
        
        ac.addAction(UIAlertAction(title: "OK", style: .Default) { [unowned self, ac] _ in
            let newCapacity = ac.textFields![0]
            
            if newCapacity == "" {
                
            } else {
                
                self.capacityButton.setTitle(String(newCapacity.text!), forState: .Normal)
                print(newCapacity.text!)
                
                
            }
            
            var capacityInt: Int? = Int(newCapacity.text!)
            
            if capacityInt != nil {
                
                self.capacity = capacityInt!
                
                //self.checkCapacity()
                
                self.updatePlacesLeft()
                
                
            } else {
                
                print("please enter a valid number")
                
            }
            
            
            })
        
        presentViewController(ac, animated: true, completion: nil)
        
    }
    
    func decrement() {
        counter--
        countLabel.text = String(counter)
        capacityForPlacesLeft++
        updatePlacesLeft()
        
        if counter == 0 {
            
            reduceButtonOutlet.enabled = false
            
        }
        
    }

    
    @IBAction func reduceButton(sender: UIButton!) {
       
            counter--
            countLabel.text = String(counter)
            capacityForPlacesLeft++
            updatePlacesLeft()
            
            if counter == 0 {
                
                reduceButtonOutlet.enabled = false
                
            
            
        }
        //checkCapacity()
        
    }
    
    @IBAction func addButton(sender: UIButton!) {
        
        counter++
        countLabel.text = String(counter)
        reduceButtonOutlet.enabled = true
        
        //checkCapacity()
        
        capacityForPlacesLeft++
        updatePlacesLeft()
        
        
    }
    
    @IBAction func restartButton(sender: AnyObject) {
        
        counter = 0
        countLabel.text = String(counter)
        //checkCapacity()
        updatePlacesLeft()
        
    }
    
    // Change color status bar
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
        
    }
    
    
}

