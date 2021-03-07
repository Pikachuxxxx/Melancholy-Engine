//
//  MeshLibrary.swift
//  Melancholy Engine
//
//  Created by Phani Srikar on 21/10/20.
//  Copyright © 2020 Phani Srikar. All rights reserved.
//

import MetalKit

enum MeshTypes {
    case Triangle_Custom
    case Quad_Custom
}
class MeshLibrary {
    
    public static var meshes: [MeshTypes:Mesh] = [:]
    
    public static func initialize(){
        createDefaultMeshes()
    }
    
    public static func createDefaultMeshes(){
        meshes.updateValue(Triangle_CustomMesh(), forKey: .Triangle_Custom)
        meshes.updateValue(Quad_CustomMesh(), forKey: .Quad_Custom)
    }
    public static func Mesh(_ meshTypes: MeshTypes)->Mesh{
        return meshes[meshTypes]!
    }
}

protocol Mesh {
    var vertexBuffer: MTLBuffer! { get }
    var vertexCount: Int! { get }
}

class customMesh: Mesh {
    var vertices: [Vertex]!
    var vertexBuffer: MTLBuffer!
    var vertexCount: Int!{
        return vertices.count
    }
    
    init() {
        createVertices()
        createBufferrs()
    }
    
    func createVertices(){ }
    
    func createBufferrs(){
        vertexBuffer = Engine.Device.makeBuffer(bytes: vertices, length: Vertex.stride(vertices.count), options: [])
    }
}

class Triangle_CustomMesh: customMesh {
    override func createVertices() {
        vertices = [
            Vertex(position: simd_float3( 0,  1, 0), color: simd_float4(1, 0, 0, 1)),
            Vertex(position: simd_float3(-1, -1, 0), color: simd_float4(0, 1, 0, 1)),
            Vertex(position: simd_float3( 1, -1, 0), color: simd_float4(0, 0, 1, 1))
        ]
    }
}

class Quad_CustomMesh: customMesh {
    override func createVertices() {
        vertices = [
            // CCW oder for both triangle's vertices
            Vertex(position: simd_float3(  1,   1, 0), color: simd_float4(1, 1, 1, 1)),   // Top Right
            Vertex(position: simd_float3( -1,   1, 0), color: simd_float4(0, 1, 1, 1)),   // Top Left
            Vertex(position: simd_float3( -1,  -1, 0), color: simd_float4(0, 0, 1, 1)),   // Bottom Left
            
            Vertex(position: simd_float3( -1,  -1, 0), color: simd_float4(0, 0, 1, 1)),    // Bottom Left
            Vertex(position: simd_float3(  1,  -1, 0), color: simd_float4(1, 0, 1, 1)),    // Bottom Right
            Vertex(position: simd_float3(  1,   1, 0), color: simd_float4(1, 1, 1, 1))     // Top Right
        ]
    }
}
