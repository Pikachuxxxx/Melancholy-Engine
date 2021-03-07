//
//  ShaderLibrary.swift
//  Melancholy Engine
//
//  Created by Phani Srikar on 09/10/20.
//  Copyright © 2020 Phani Srikar. All rights reserved.
//

import MetalKit

enum VetexShaderTypes {
    case Basic
}

enum FragmentShaderTypes {
    case Basic
}

class ShaderLibrary {
    public static var DefaultLibrary: MTLLibrary!
    
    private static var vertexShaders: [VetexShaderTypes: Shader] = [:]
    private static var fragmentShaders: [FragmentShaderTypes: Shader] = [:]
    
    public static func initialize(){
        DefaultLibrary = Engine.Device.makeDefaultLibrary()
        createDefaultShaders()
    }
    
    public static func createDefaultShaders() {
        // Vertex Shaders
        vertexShaders.updateValue(Basic_VertexShader(), forKey: .Basic)
        // Fragment Shaders
        fragmentShaders.updateValue(Basic_FragmentShader(), forKey: .Basic)
    }
    
    public static func vertex(_ vertexShaderType: VetexShaderTypes)->MTLFunction{
        return vertexShaders[vertexShaderType]!.function
    }
    
    public static func fragment(_ fragmentShaderType: FragmentShaderTypes)->MTLFunction{
        return fragmentShaders[fragmentShaderType]!.function
    }
}

// A protocol for using the shaders
protocol Shader {
    // The name of the shader for verbatum
    var name: String {get}
    // The actual function name that's in the metal shader file
    var functionName: String {get}
    // The actual Metal Shader function
    var function: MTLFunction! {get}
}

public struct Basic_VertexShader: Shader{
    public var name: String = "Basic_Vertex_Shader"
    public var functionName: String = "basic_vertex_shader"
    public var function: MTLFunction!
    init(){
        function = ShaderLibrary.DefaultLibrary.makeFunction(name: functionName)
        function?.label = name
    }
}

public struct Basic_FragmentShader: Shader{
    public var name: String = "Basic_Fragment_Shader"
    public var functionName: String = "basic_fragment_shader"
    public var function: MTLFunction!
    init(){
        function = ShaderLibrary.DefaultLibrary.makeFunction(name: functionName)
        function?.label = name
    }
}
