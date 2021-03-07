//
//  Node.swift
//  Melancholy Engine
//
//  Created by Phani Srikar on 21/10/20.
//  Copyright © 2020 Phani Srikar. All rights reserved.
//

import MetalKit

class Node {
    
    var position: simd_float3 = simd_float3(repeating: 0)
    var scale: simd_float3 = simd_float3(repeating: 1)
    var rotation: simd_float3 = simd_float3(repeating: 0)
     
    var modelMatrix: matrix_float4x4{
        var model = matrix_identity_float4x4
        model.translate(direction: position)
        model.rotate(angle: rotation.x, axis: X_AXIS)
        model.rotate(angle: rotation.y, axis: Y_AXIS)
        model.rotate(angle: rotation.z, axis: Z_AXIS)
        model.scale(axis: scale)
        return model
    }
    
    var children: [Node] = []
    
    func addChild(_ child: Node){
        children.append(child)
    }
    
    func update(deltaTime: Float){
        for child in children{
            child.update(deltaTime: deltaTime )
        }
    }
    
    func render(renderCommandEncoder: MTLRenderCommandEncoder){
        for child in children{
            child.render(renderCommandEncoder: renderCommandEncoder)
        } 
        if let renderable = self as? Renderable{
            renderable.renderRenderable(renderCommandEncoder)
        }
    }
    
}
