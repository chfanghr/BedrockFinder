//
//  RNG.swift
//  
//
//  Created by 方泓睿 on 2022/1/30.
//

internal protocol RNG {
    init(seed: Int64)
    init(seed: Int64, hash: String)
    func next(bits: UInt8) -> Int32
    func next() -> Int64
}

internal extension RNG {
    func next() -> Float32 {
        Float32(self.next(bits: 24)) * 5.9604645e-8
    }
}

