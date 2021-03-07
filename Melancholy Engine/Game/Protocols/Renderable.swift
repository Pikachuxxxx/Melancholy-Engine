//
//  Renderable.swift
//  Melancholy Engine
//
//  Created by Phani Srikar on 21/10/20.
//  Copyright © 2020 Phani Srikar. All rights reserved.
//

import MetalKit

protocol Renderable {
    func renderRenderable(_ renderCommandEncoder: MTLRenderCommandEncoder)
}
