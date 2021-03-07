//
//  SceneManager.swift
//  Melancholy Engine
//
//  Created by Phani Srikar on 21/10/20.
//  Copyright © 2020 Phani Srikar. All rights reserved.
//

import MetalKit

enum SceneTypes{
    case SandBox
}

class SceneManager{
    
    private static var _currentScene: Scene!
    
    public static func initialize(_ sceneType: SceneTypes){
        SetScene(sceneType)
    }
    
    public static func SetScene(_ sceneType: SceneTypes){
        switch sceneType {
        case .SandBox:
            _currentScene = SandBoxScene()
        }
    }
    
    public static func TickScene(renderCommandEncoder: MTLRenderCommandEncoder, deltaTime: Float){
        
        _currentScene.update(deltaTime: deltaTime)
        _currentScene.render(renderCommandEncoder: renderCommandEncoder)
    }
    
}
