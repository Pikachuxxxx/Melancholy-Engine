import MetalKit

class Engine {
    
    public static var Device:       MTLDevice!
    public static var CommandQueue: MTLCommandQueue!
    
    public static func Ignite(device: MTLDevice){
        self.Device = device
        self.CommandQueue = device.makeCommandQueue()
        
        // Initialize all the Metal Libraries
        ShaderLibrary.initialize()
        VertexDescriptorLibrary.initialize()
        RenderPipelineDescriptorLibrary.initialize()
        RenderPipelineStateLibrary.initialize()
        MeshLibrary.initialize()
        
        // Other initializations
        SceneManager.initialize(Preferences.StartingSceneType)
    }
    
    
}
