import MetalKit

public enum ClearColors{
    static let LightGreen: MTLClearColor = MTLClearColor(red: 0.1, green: 0.8, blue: 0.1, alpha: 1.0)
    static let LightRed:   MTLClearColor = MTLClearColor(red: 0.8, green: 0.2, blue: 0.2, alpha: 1.0)
    static let White:      MTLClearColor = MTLClearColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    static let Black:      MTLClearColor = MTLClearColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
}

class Preferences {
    public static var ClearColor:      MTLClearColor  = ClearColors.LightRed
    public static var MainPixelFormat: MTLPixelFormat = MTLPixelFormat.bgra8Unorm
}


            
