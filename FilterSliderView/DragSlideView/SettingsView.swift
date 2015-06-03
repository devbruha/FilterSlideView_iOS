//
//  SettingsView.swift
//  DragSlideView
//
//  Created by Training on 07/01/15.
//  Copyright (c) 2015 Training. All rights reserved.
//

import UIKit
import SwiftForms




class SettingsView: FXBlurView {


    
    var animator:UIDynamicAnimator!
    var container:UICollisionBehavior!
    var snap:UISnapBehavior!
    var dynamicItem:UIDynamicItemBehavior!
    var gravity:UIGravityBehavior!
    
    var label = UILabel(frame: CGRectMake(0, 0, 200, 21))
    
    var panGestureRecognizer:UIPanGestureRecognizer!
    
    
    func setup () {
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "handlePan:")
        panGestureRecognizer.cancelsTouchesInView = false
        
        self.addGestureRecognizer(panGestureRecognizer)
        
        animator = UIDynamicAnimator(referenceView: self.superview!)
        dynamicItem = UIDynamicItemBehavior(items: [self])
        dynamicItem.allowsRotation = false
        dynamicItem.elasticity = 0
        
        gravity = UIGravityBehavior(items: [self])
        gravity.gravityDirection = CGVectorMake(0, 1)
        
        container = UICollisionBehavior(items: [self])

        configureContainer()
        
        animator.addBehavior(gravity)
        animator.addBehavior(dynamicItem)
        animator.addBehavior(container)
        
        label.center = CGPointMake(160, 284)
        label.textAlignment = NSTextAlignment.Center
        label.text = "I'am a test label"
        self.addSubview(label)

        
      
        

        
    
        
    }
    
    func configureContainer (){
        let boundaryWidth = UIScreen.mainScreen().bounds.size.width
        container.addBoundaryWithIdentifier("upper", fromPoint: CGPointMake(0, -self.frame.size.height + 66), toPoint: CGPointMake(boundaryWidth, -self.frame.size.height + 66))
        
        let boundaryHeight = UIScreen.mainScreen().bounds.size.height
        container.addBoundaryWithIdentifier("lower", fromPoint: CGPointMake(0, boundaryHeight), toPoint: CGPointMake(boundaryWidth, boundaryHeight))
        
        
    }
    
    func handlePan (pan:UIPanGestureRecognizer){
        let velocity = pan.velocityInView(self.superview).y
        
        var movement = self.frame
        movement.origin.x = 0
        movement.origin.y = movement.origin.y + (velocity * 0.05)
        
        if pan.state == .Ended {
            panGestureEnded()
        }else if pan.state == .Began {
            snapToBottom()
        }else{
            animator.removeBehavior(snap)
            snap = UISnapBehavior(item: self, snapToPoint: CGPointMake(CGRectGetMidX(movement), CGRectGetMidY(movement)))
            animator.addBehavior(snap)
        }
        
    }
    
    func panGestureEnded () {
        animator.removeBehavior(snap)
        
        let velocity = dynamicItem.linearVelocityForItem(self)
        
        if fabsf(Float(velocity.y)) > 100 {
            if velocity.y < 0 {
                snapToTop()
            }else{
                snapToBottom()
            }
        }else{
            if let superViewHeigt = self.superview?.bounds.size.height {
                if self.frame.origin.y > superViewHeigt / 2 {
                    snapToBottom()
                }else{
                    snapToTop()
                }
            }
        }
        
    }
    
    func snapToBottom() {
        gravity.gravityDirection = CGVectorMake(0, 2.5)
    }
    
    func snapToTop(){
        gravity.gravityDirection = CGVectorMake(0, -2.5)
    }
    

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.tintColor = UIColor.clearColor()
        
    }
    
    
  
    

}


