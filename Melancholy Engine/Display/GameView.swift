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

    
    var renderer: Renderer!
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        
        self.device = MTLCreateSystemDefaultDevice()
        
        Engine.Ignite(device: device!)
        
        self.clearColor = Preferences.ClearColor
        
        self.colorPixelFormat = Preferences.MainPixelFormat
                
        self.renderer = Renderer()
        
        self.delegate = renderer
    }
    
  
    // Mouse Input
    
    // Keyboard Input

}
