//
//  LegacyRNG.swift
//
// LegacyRNG.swift
//
//
//  Created by 方泓睿 on 2022/1/30.
//

fileprivate let magic: UInt64 = 0x5DEECE66D
fileprivate let mask: UInt64 = ((1 << 48) - 1)

internal class LegacyRNG: RNG {
    private var state: UInt64

    required init(seed: Int64) {
        state = (UInt64(bitPattern: seed) ^ magic) & mask
    }

    required convenience init(seed: Int64, hash: String) {
        let seeder = LegacyRNG(seed: seed)

        self.init(seed: seeder.next() ^ Int64(truncatingIfNeeded: javaStringHash(hash)))
    }

    func next(bits: UInt8) -> Int32 {
        assert(bits <= 32)

        state = (state &* magic &+ 0xb) & mask

        return Int32(truncatingIfNeeded: Int64(bitPattern: state) >> (48 - bits))
    }

    func next() -> Int64 {
        let top = Int64(truncatingIfNeeded: next(bits: 32))
        let bottom = Int64(truncatingIfNeeded: next(bits: 32))
        let result = (top << 32) + bottom

        return result
    }
}
