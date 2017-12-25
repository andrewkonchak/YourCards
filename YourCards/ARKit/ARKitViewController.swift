//
//  ViewController.swift
//  ARKitGame
//
//  Created by Andrew Konchak on 22.06.17.
//  Copyright © 2017 Andrew Konchak. All rights reserved.
//

import UIKit
import ARKit

class ARKitViewController: UIViewController {

    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var gradientView: UIView!
    
    var currentColorArrayIndex = -1
    var colorArray: [(color1: UIColor, color2: UIColor)] = []
    var counter:Int = 0 {
        didSet {
            counterLabel.text = "\(counter)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = SCNScene()
        sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        
        // Run the view's session
        sceneView.session.run(configuration)
        addObject()
    }
    
    // MARK: - Remove ship when we touch it
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first {
            let location = touch.location(in: sceneView)
            
            let hitList = sceneView.hitTest(location, options: nil)
            
            if let hitObject = hitList.first {
                let node = hitObject.node
                
    //            if node.name == "ARShip" {
                    counter += 1
                    node.removeFromParentNode()
                    addObject()
                }
            
    //        }
        }
    }
    
    func addObject() {
        let ship = SpaceShip()
        ship.loadModal()
        
        // random ship position
        
        let xPos = randomPosition(lowerBound: -1.5, upperBound: 1.5)
        let yPos = randomPosition(lowerBound: -1.5, upperBound: 1.5)
        
        ship.position = SCNVector3(xPos, yPos, -1)
        
        sceneView.scene.rootNode.addChildNode(ship)
        
    }
    
    func randomPosition (lowerBound lower:Float, upperBound upper:Float) -> Float {
        return Float(arc4random()) / Float(UInt32.max) * (lower - upper) + upper
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

