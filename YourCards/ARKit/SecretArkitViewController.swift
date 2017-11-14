//
//  SecretArkitViewController.swift
//  YourCards
//
//  Created by Andrew on 11/12/17.
//  Copyright © 2017 Andrew Konchak. All rights reserved.
//

import UIKit
import ARKit

class SecretArkitViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var counterLabel: UILabel!

    //Points
    var counter: Int = 0 {
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
        let configuration = ARWorldTrackingConfiguration()
        //device configuration and position
        sceneView.session.run(configuration)
        
        addObject()
    }
    
    func addObject() {
        let ship = ARkitModel()
        ship.loadModel()
        
        let xPosition = randomPosition(lowerBound: -1.5, upperBound: 1.5)
        let yPosition = randomPosition(lowerBound: -1.5, upperBound: 1.5)
        
        ship.position = SCNVector3(xPosition, yPosition, -1)
        
        sceneView.scene.rootNode.addChildNode(ship)
    }
    
    // random position to ship
    func randomPosition (lowerBound lower: Float, upperBound upper: Float) -> Float {
        return Float(arc4random()) / Float(UInt32.max) * (lower - upper) + upper
    }
    
    //tap or touch on ship
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: sceneView)
            
            let hitList = sceneView.hitTest(location, options: nil)
            
            if let hitObject = hitList.first {
                let node = hitObject.node
                
                // hit ship(object)
                if node.name == "ARShip" {
                    counter += 1
                    node.removeFromParentNode()
                    addObject()
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
