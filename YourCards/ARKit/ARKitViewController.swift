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
    @IBOutlet weak var gradientView: UIViewX!
    
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
        
        // MARK: - Multithreading Asynchronal
//        DispatchQueue.main.async {
//            self.animateBackgroundColor()
//        }
        
        //        DispatchQueue.main.async {
//            self.animateBackgroundColor()
//        }
        
        DispatchQueue.global().async {
            self.animateBackgroundColor()
        }
       
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
    
    // MARK: - Animate background color
    
    func animateBackgroundColor(){
        
        colorArray.append((color1: #colorLiteral(red: 0.6502587795, green: 0.1714085937, blue: 0.4642885923, alpha: 1), color2: #colorLiteral(red: 0.5290039182, green: 0.235301286, blue: 0.5726263523, alpha: 1)))
        colorArray.append((color1: #colorLiteral(red: 0.5290039182, green: 0.235301286, blue: 0.5726263523, alpha: 1), color2: #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)))
        colorArray.append((color1: #colorLiteral(red: 0.1604961157, green: 0.3959937096, blue: 0.5647168756, alpha: 1), color2: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)))
        colorArray.append((color1: #colorLiteral(red: 0.3136580586, green: 0.7570564151, blue: 0.9673162103, alpha: 1), color2: #colorLiteral(red: 0.1960784314, green: 0.5843137255, blue: 0.5294117647, alpha: 1)))
        colorArray.append((color1: #colorLiteral(red: 0.1960784314, green: 0.5843137255, blue: 0.5294117647, alpha: 1), color2: #colorLiteral(red: 0.1610812545, green: 0.1788645983, blue: 0.2052916586, alpha: 1)))
        colorArray.append((color1: #colorLiteral(red: 0.1610812545, green: 0.1788645983, blue: 0.2052916586, alpha: 1), color2: #colorLiteral(red: 0.6502587795, green: 0.1714085937, blue: 0.4642885923, alpha: 1)))
        
        currentColorArrayIndex = currentColorArrayIndex == (colorArray.count - 1) ? 0 : currentColorArrayIndex + 1
        
        UIView.transition(with: gradientView, duration: 2, options: [.transitionCrossDissolve], animations: {
            self.gradientView.firstColor = self.colorArray[self.currentColorArrayIndex].color1
            self.gradientView.secondColor = self.colorArray[self.currentColorArrayIndex].color2
        }) { (success) in
            
            self.animateBackgroundColor()
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

