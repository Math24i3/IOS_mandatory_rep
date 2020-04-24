//
//  AnimationManager.swift
//  ShakeDemo
//
//  Created by Mathias Møller Feldt on 24/04/2020.
//  Copyright © 2020 Mathias Møller. All rights reserved.
//

import UIKit

// Manages the life cycle of the  animation
internal struct AnimationManager {

    fileprivate let itemLayer = CAEmitterLayer()
    fileprivate lazy var itemCell: CAEmitterCell = {
        let itemCell = CAEmitterCell()
        itemCell.contents = UIImage(named: "candy")?.cgImage
        itemCell.scale = 0.06
        itemCell.scaleRange = 0.3
        itemCell.emissionRange = .pi
        itemCell.lifetime = 20.0
        itemCell.birthRate = 10
        itemCell.velocity = -30
        itemCell.velocityRange = -20
        itemCell.yAcceleration = 30
        itemCell.xAcceleration = 5
        itemCell.spin = -0.5
        itemCell.spinRange = 1.0
        return itemCell
    }()

    //Starts animation
    mutating func injectItemLayer(into view: UIView) {
        itemLayer.emitterPosition = CGPoint(x: view.bounds.width / 2.0, y: -50)
        itemLayer.emitterSize = CGSize(width: view.bounds.width, height: 0)
        itemLayer.emitterShape = CAEmitterLayerEmitterShape.line
        itemLayer.beginTime = CACurrentMediaTime()
        itemLayer.timeOffset = CFTimeInterval(arc4random_uniform(6) + 5)
        itemLayer.emitterCells = [itemCell]

        view.layer.addSublayer(itemLayer)
    }

    // Removes animation
    func removeLayer() {
        itemLayer.removeFromSuperlayer()
    }

}
