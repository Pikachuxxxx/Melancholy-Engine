import simd

protocol sizeable { }

extension sizeable{
    static var size: Int{
        return MemoryLayout<Self>.size
    }
    static var stride: Int{
        return MemoryLayout<Self>.stride
    }
    static func size(_ count: Int)->Int{
        return MemoryLayout<Self>.size * count
    }
    static func stride(_ count:Int)->Int{
        return MemoryLayout<Self>.stride * count
    }
}

extension simd_float3 : sizeable { }

struct Vertex : sizeable{
    var position : simd_float3
    var color    : simd_float4
}

