//
//  File.swift
//  PuttMetricsAPP
//
//  Created by User on 1/15/18.
//  Copyright © 2018 DustinPerry. All rights reserved.
//

import UIKit

class EmitterUP {
    static func get(with image: UIImage) -> CAEmitterLayer {
        let emitter = CAEmitterLayer()
        emitter.emitterShape = kCAEmitterLayerLine
        emitter.emitterCells = generateEmitterCells(with: image)
        
        return emitter
    }
    
    
    
   static func generateEmitterCells(with image: UIImage) -> [CAEmitterCell] {
        var cells = [CAEmitterCell]()
        
        let cell = CAEmitterCell()
        cell.contents = image.cgImage
        cell.birthRate = 0.7
        cell.lifetime = 50
        cell.velocity = CGFloat(115)
        cell.emissionLongitude = (370 * (.pi/180))
        cell.emissionRange = (15 * (.pi/180))
        cell.scale = 0.45
    
        cell.spin = CGFloat(5)
        cell.alphaRange = 0.3
    
 
    
        cells.append(cell)
//        cells.append(cell1)

    
        return cells
    }
    
    
}


class EmitterDown {
    static func get(with image: UIImage) -> CAEmitterLayer {
        let emitter = CAEmitterLayer()
        emitter.emitterShape = kCAEmitterLayerLine
        emitter.emitterCells = generateEmitterCells(with: image)
        
        return emitter
    }
    
    
    
    static func generateEmitterCells(with image: UIImage) -> [CAEmitterCell] {
        var cells = [CAEmitterCell]()
        
        let cell = CAEmitterCell()
        cell.contents = image.cgImage
        cell.birthRate = 0.7
        cell.lifetime = 50
        cell.velocity = CGFloat(115)
        cell.emissionLongitude = (180 * (.pi/180))
        cell.emissionRange = (15 * (.pi/180))
        cell.scale = 0.45
        
        cell.spin = CGFloat(5)
        cell.alphaRange = 0.3
        
        
        
        cells.append(cell)
        //        cells.append(cell1)
        
        
        return cells
    }
    
    
}
