//
//  GameView.swift
//  Melancholy Engine
//
//  Created by Phani Srikar on 12/09/20.
//  Copyright © 2020 Phani Srikar. All rights reserved.
//

import Cocoa
import MetalKit

class GameView: MTKView {
    
    var commandQ: MTLCommandQueue!
    var renderPipelineState: MTLRenderPipelineState!
    
    let vertices: [simd_float3] = [
        simd_float3( 0,  1,  0),
        simd_float3(-1, -1,  0),
        simd_float3( 1, -1,  0)
    ]
    
    var vertexBuffer: MTLBuffer!
    
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        
        self.device = MTLCreateSystemDefaultDevice()
        self.clearColor = MTLClearColor(red: 0.8, green: 0.1, blue: 0.1, alpha: 1.0)
        self.colorPixelFormat = .bgra8Unorm
        
        self.commandQ = device?.makeCommandQueue()
        
        createRenderPipelineState()
        
        createBufferrs()
    }
    
    func createBufferrs(){
        vertexBuffer = device?.makeBuffer(bytes: vertices,
                                          length: MemoryLayout<simd_float3>.stride * vertices.count,
                                          options: [])
    }
    
    func createRenderPipelineState(){
        let library = device?.makeDefaultLibrary()
        let vertexFunction = library?.makeFunction(name: "basic_vertex_shader")
        let fragmentFunction = library?.makeFunction(name: "basic_fragment_shader")
        
        let descriptor = MTLRenderPipelineDescriptor()
        descriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
        descriptor.vertexFunction = vertexFunction
        descriptor.fragmentFunction = fragmentFunction
        
        do{
            renderPipelineState = try device?.makeRenderPipelineState(descriptor: descriptor)
        }catch let error as NSError{
            print(error)
        }
    }
    
    override func draw(_ dirtyRect: NSRect) {
        guard let drawable = self.currentDrawable,
        let renderPassDescriptor = self.currentRenderPassDescriptor  else{ return }
            
        let commandBuffer = commandQ.makeCommandBuffer()
        let renderCommandEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: renderPassDescriptor)
        renderCommandEncoder?.setRenderPipelineState(renderPipelineState)
        
        renderCommandEncoder?.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        renderCommandEncoder?.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: vertices.count) 
        
        renderCommandEncoder?.endEncoding()
        commandBuffer?.present(drawable)
        commandBuffer?.commit()
    }
    

}
