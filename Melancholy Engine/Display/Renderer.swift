//
//  Renderer.swift
//  Melancholy Engine
//
//  Created by Phani Srikar on 20/10/20.
//  Copyright © 2020 Phani Srikar. All rights reserved.
//

import MetalKit

class Renderer: NSObject {
     
}

extension Renderer: MTKViewDelegate{
    
    // Called when the window is resized
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        
    }
    
    // The main draw function
    func draw(in view: MTKView) {
        guard let drawable = view.currentDrawable,
        let renderPassDescriptor = view.currentRenderPassDescriptor  else{ return }
            
        let commandBuffer = Engine.CommandQueue.makeCommandBuffer()
        let renderCommandEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: renderPassDescriptor)
        SceneManager.TickScene(renderCommandEncoder: renderCommandEncoder!, deltaTime: 1 / Float(view.preferredFramesPerSecond))
        renderCommandEncoder?.endEncoding()
        commandBuffer?.present(drawable)
        commandBuffer?.commit()
    }
    
    
}
