//
//  LegacyPosRNG.swift
//  
//
//  Created by 方泓睿 on 2022/1/30.
//

import Foundation

internal struct LegacyPosRNGProvider: PosRNGProvider {
    private let rseed: Int64

    init(world: RNG) {
        rseed = world.next()
    }

    func at(x: Int32, y: Int32, z: Int32) -> RNG {
        let peed = posToSeed(x: x, y: y, z: z)

        return LegacyRNG(seed: rseed ^ peed)
    }
}
