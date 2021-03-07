//
//  basicShaders.metal
//  Melancholy Engine
//
//  Created by Phani Srikar on 12/09/20.
//  Copyright © 2020 Phani Srikar. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;

struct VertexIn
{
    float3 position [[ attribute(0) ]];
    float4 color    [[ attribute(1) ]];
};

struct ReasterizerData
{
    float4 position [[ position ]];
    float4 color;
};

struct ModelConstants
{
    float4x4 modelMatrix;
    
};
vertex ReasterizerData basic_vertex_shader(const VertexIn vIn [[ stage_in ]], constant ModelConstants& modelConstants [[ buffer(1) ]] )
{
    ReasterizerData rd;
    
    rd.position = modelConstants.modelMatrix * float4(vIn.position, 1);
    rd.color = vIn.color;
    
    return rd;
}

fragment half4 basic_fragment_shader(ReasterizerData rd [[ stage_in ]])
{
    float4 color = rd.color;
    
    return half4(color.x, color.y, color.z, color.w);
}
