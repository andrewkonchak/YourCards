//
//  ARkitModel.swift
//  YourCards
//
//  Created by Andrew on 11/12/17.
//  Copyright © 2017 Andrew Konchak. All rights reserved.
//

import ARKit

class ARkitModel: SCNNode {
    
    func loadModel() {
        guard let virtualObjectScene = SCNScene(named: "art.scnassets/ship.scn") else {return}
        
        let wrapperNode = SCNNode()
        
        for child in virtualObjectScene.rootNode.childNodes{
            wrapperNode.addChildNode(child)
        }
        
        self.addChildNode(wrapperNode)
}
}
