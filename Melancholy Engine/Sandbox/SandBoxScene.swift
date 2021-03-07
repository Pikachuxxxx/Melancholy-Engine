//
//  SandBoxScene.swift
//  Melancholy Engine
//
//  Created by Phani Srikar on 21/10/20.
//  Copyright © 2020 Phani Srikar. All rights reserved.
//

import MetalKit

class SandBoxScene: Scene{
    
    override func buildScene() {
        for x in -5..<5 {
            for y in -5..<5 {
                let gameObject: GameObject = GameObject(meshType: MeshTypes.Triangle_Custom)
                gameObject.position.x = Float(Float(x) + 0.5) / 5
                gameObject.position.y = Float(Float(y) + 0.5) / 5
                gameObject.scale = simd_float3(repeating: 0.1)
                addChild(gameObject)
            }
        }
    }
    
    override func update(deltaTime: Float) {
        for child in children{
            child.rotation.z += 0.05
        }
        super.update(deltaTime: deltaTime)
    }
}
