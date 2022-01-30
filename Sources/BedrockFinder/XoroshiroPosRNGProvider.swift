//
//  XoroshiroPosRNGProvider.swift
//  
//
//  Created by 方泓睿 on 2022/1/30.
//

struct XoroshiroPosRNGProvider: PosRNGProvider {
    let rseeds: (UInt64, UInt64)

    init(world: RNG) {
        rseeds = (
                UInt64(bitPattern: world.next()),
                UInt64(bitPattern: world.next())
        )
    }

    func at(x: Int32, y: Int32, z: Int32) -> RNG {
        let pseed = posToSeed(x: x, y: y, z: z)

        return XoroshiroRNG(seed: (
                UInt64(bitPattern: pseed) ^ rseeds.0,
                rseeds.1
        ))
    }
}
