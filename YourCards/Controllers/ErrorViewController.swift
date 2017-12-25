//
//  ErrorViewController.swift
//  YourCards
//
//  Created by Andrew on 12/25/17.
//  Copyright © 2017 Andrew Konchak. All rights reserved.
//

import UIKit

class ErrorViewController: UIViewController {
    
    @IBOutlet weak var imageRobot: UIImageView!
    
    var animator = UIDynamicAnimator()
    var snapBehavior: UISnapBehavior?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        createGestureRecognizer()
        createAnimatorAndBehaviors()
    }
    
    func createGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tap)
    }
    
    
    func createAnimatorAndBehaviors() {
        animator = UIDynamicAnimator(referenceView: view)
        let collision = UICollisionBehavior(items: [imageRobot])
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
        
        snapBehavior = UISnapBehavior(item: imageRobot, snapTo: imageRobot.center)
        snapBehavior?.damping = 0.5
        animator.addBehavior(snapBehavior!)
        
    }
    
    @objc func handleTap(PattemTap: UITapGestureRecognizer) {
        let tapPoint = PattemTap.location(in: view)
        if snapBehavior != nil {
            animator.removeBehavior(snapBehavior!)
        }
        snapBehavior = UISnapBehavior(item: imageRobot, snapTo: tapPoint)
        snapBehavior?.damping = 0.5
        animator.addBehavior(snapBehavior!)
        
    }
    
}
