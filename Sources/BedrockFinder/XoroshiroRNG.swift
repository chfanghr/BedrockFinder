//
//  XoroshiroRNG.swift
//  
//
//  Created by 方泓睿 on 2022/1/30.
//

import Crypto

fileprivate let magic0: UInt64 = 0x6a09e667f3bcc909
fileprivate let magic1: UInt64 = 0x9e3779b97f4a7c15

fileprivate func seed128(seed: Int64) -> (UInt64, UInt64) {
    let lo = UInt64(bitPattern: seed) ^ magic0
    let hi = lo &+ magic1
    return (mix(lo), mix(hi))
}

fileprivate func mix(_ v: UInt64) -> UInt64 {
    var x = v

    x = (x ^ (x >> 30)) &* 0xbf58476d1ce4e5b9
    x = (x ^ (x >> 27)) &* 0x94d049bb133111eb

    return x ^ (x >> 31);
}

internal class XoroshiroRNG: RNG {
    private var states: (UInt64, UInt64)

    required convenience init(seed: Int64) {
        self.init(seed: seed128(seed: seed))
    }

    init(seed: (UInt64, UInt64)) {
        states = seed
        if states.0 == 0 && states.1 == 0 {
            states = (magic1, magic0)
        }
    }

    required convenience init(seed: Int64, hash str: String) {
        let seeder = XoroshiroRNG(seed: seed)

        let hash: [UInt8] = Array(Insecure.MD5.hash(data: str.data(using: .utf8)!))

        let hseed = (
                UInt64(bigEndian: hash.withUnsafeBytes { $0.load(as: UInt64.self) }),
                UInt64(bigEndian: hash.withUnsafeBytes { $0.load(fromByteOffset: 8, as: UInt64.self) })
        )

        self.init(seed: (
                hseed.0 ^ UInt64(bitPattern: seeder.next()),
                hseed.1 ^ UInt64(bitPattern: seeder.next())
        ))
    }

    func next(bits: UInt8) -> Int32 {
        assert(bits <= 32)
        let shift = 64 - bits
        assert(shift <= 63)
        let rbits = UInt64(bitPattern: next())
        return Int32(exactly: rbits >> shift)!
    }

    func next() -> Int64 {
        let v = ((states.0 &+ states.1) <<< 17) &+ states.0
        states.1 ^= states.0
        states.0 = (states.0 <<< 49) ^ states.1 ^ (states.1 << 21)
        states.1 = states.1 <<< 28
        return Int64(bitPattern: v)
    }
}

