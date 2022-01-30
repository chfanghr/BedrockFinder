//
//  PosRNGProvider.swift
//  
//
//  Created by 方泓睿 on 2022/1/30.
//

import Foundation

internal protocol PosRNGProvider {
    init(world: RNG)
    func at(x: Int32, y: Int32, z: Int32) -> RNG
}

internal func posToSeed(x: Int32, y: Int32, z: Int32) -> Int64 {
    var seed = Int64(x &* 3129871) ^ (Int64(z) &* 116129781) ^ Int64(y)
    seed = seed &* seed &* 42317861 &+ seed &* 0xb
    return seed >> 16
}
