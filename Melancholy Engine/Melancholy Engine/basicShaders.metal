//
//  basicShaders.metal
//  Melancholy Engine
//
//  Created by Phani Srikar on 12/09/20.
//  Copyright © 2020 Phani Srikar. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;

struct VertexIn{
    float3 position;
    float4 color;
};

struct ReasterizerData{
    float4 position [[ position ]];
    float4 color;
};

vertex ReasterizerData basic_vertex_shader(const device VertexIn *vertices [[ buffer(0) ]],
                                  uint vertexID [[ vertex_id ]]){
    ReasterizerData rd;
    
    rd.position = float4(vertices[vertexID].position, 1);
    rd.color = vertices[vertexID].color;
    
    return rd;
}

fragment half4 basic_fragment_shader(ReasterizerData rd [[ stage_in ]]){
    float4 color = rd.color;
    
    return half4(color.x, color.y, color.z, color.w);
}
