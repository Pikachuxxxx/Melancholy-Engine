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
        
    var renderPipelineState: MTLRenderPipelineState!
    
    var vertices: [Vertex]!
    
    var vertexBuffer: MTLBuffer!
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        
        self.device = MTLCreateSystemDefaultDevice()
        
        Engine.Ignite(device: device!)
        
        self.clearColor = Preferences.ClearColor
        self.colorPixelFormat = Preferences.MainPixelFormat
                
        createRenderPipelineState()
        createVertices()
        createBufferrs()
    }
    
    func createVertices(){
        vertices = [
        Vertex(position: simd_float3( 0,  1, 0), color: simd_float4(1, 0, 0, 1)),
        Vertex(position: simd_float3(-1, -1, 0), color: simd_float4(0, 1, 0, 1)),
        Vertex(position: simd_float3( 1, -1, 0), color: simd_float4(0, 0, 1, 1))
        ]
    }
    
    func createBufferrs(){
        vertexBuffer = Engine.Device .makeBuffer(bytes: vertices,
                                          length: Vertex.stride(vertices.count),
                                          options: [])
    }
    
    func createRenderPipelineState(){
        let library = Engine.Device.makeDefaultLibrary()
        let vertexFunction   = library?.makeFunction(name: "basic_vertex_shader")
        let fragmentFunction = library?.makeFunction(name: "basic_fragment_shader")
        
        let vertexDescriptor = MTLVertexDescriptor()
        
        // Attrib 1 : Position
        vertexDescriptor.attributes[0].format = .float3
        vertexDescriptor.attributes[0].bufferIndex = 0
        vertexDescriptor.attributes[0].offset = 0
        
        // Attrib 2 : Color
        vertexDescriptor.attributes[1].format = .float4
        vertexDescriptor.attributes[1].bufferIndex = 0
        vertexDescriptor.attributes[1].offset = simd_float3.size
        
        vertexDescriptor.layouts[0].stride = Vertex.stride
        
        let descriptor = MTLRenderPipelineDescriptor()
        descriptor.colorAttachments[0].pixelFormat = Preferences.MainPixelFormat
        descriptor.vertexFunction = vertexFunction
        descriptor.fragmentFunction = fragmentFunction
        descriptor.vertexDescriptor = vertexDescriptor
        
        do{
            renderPipelineState = try Engine.Device.makeRenderPipelineState(descriptor: descriptor)
        }catch let error as NSError{
            print(error)
        }
    }
    
    override func draw(_ dirtyRect: NSRect) {
        guard let drawable = self.currentDrawable,
        let renderPassDescriptor = self.currentRenderPassDescriptor  else{ return }
            
        let commandBuffer = Engine.CommandQueue.makeCommandBuffer()
        let renderCommandEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: renderPassDescriptor)
        renderCommandEncoder?.setRenderPipelineState(renderPipelineState)
        
        renderCommandEncoder?.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        renderCommandEncoder?.drawPrimitives(type: .triangle,
                                             vertexStart: 0,
                                             vertexCount: vertices.count) 
        
        renderCommandEncoder?.endEncoding()
        commandBuffer?.present(drawable)
        commandBuffer?.commit()
    }
}
