//
// GradientGenerator.swift
//
//
// Created by 方泓睿 on 2022/1/30.
//

fileprivate let bedrockFloor = "minecraft:bedrock_floor"
fileprivate let bedrockRoof = "minecraft:bedrock_roof"

public let overworldBedrockRange = Int32(-59)...(-64)
public let netherFloorBedrockRange = Int32(0)...5
public let netherCeilingBedrockRange = Int32(122)...127

public struct GradientGenerator {
    private let rand: PosRNGProvider
    private let lower: Block
    private let upper: Block
    private let lowerY: Int32
    private let upperY: Int32

    private init(rand: PosRNGProvider, lower: Block, upper: Block, lowerY: Int32, upperY: Int32) {
        self.rand = rand
        self.lower = lower
        self.upper = upper
        self.lowerY = lowerY
        self.upperY = upperY
    }

    func at(x: Int32, y: Int32, z: Int32) -> Block {
        if y <= lowerY {
            return lower
        }
        if y >= upperY {
            return upper
        }

        let fac = 1 - normalize(
                x: Float64(y),
                zero: Float64(lowerY),
                one: Float64(upperY))

        let nextRand: Float32 = rand.at(x: x, y: y, z: z).next()

        if Float64(nextRand) < fac {
            return lower
        }

        return upper
    }

    public static func overworldFloor(seed: Int64) -> GradientGenerator {
        let rng = XoroshiroRNG(seed: seed, hash: bedrockFloor)
        return GradientGenerator(
                rand: XoroshiroPosRNGProvider(world: rng),
                lower: .bedrock, upper: .other,
                lowerY: overworldBedrockRange.lowerBound,
                upperY: overworldBedrockRange.upperBound)
    }

    public static func netherFloor(seed: Int64) -> GradientGenerator {
        let rng = LegacyRNG(seed: seed, hash: bedrockFloor)
        return GradientGenerator(
                rand: LegacyPosRNGProvider(world: rng),
                lower: .bedrock, upper: .other,
                lowerY: netherFloorBedrockRange.lowerBound,
                upperY: netherFloorBedrockRange.upperBound)
    }

    public static func netherCeiling(seed: Int64) -> GradientGenerator {
        let rng = LegacyRNG(seed: seed, hash: bedrockRoof)
        return GradientGenerator(
                rand: LegacyPosRNGProvider(world: rng),
                lower: .other, upper: .bedrock,
                lowerY: netherCeilingBedrockRange.lowerBound,
                upperY: netherCeilingBedrockRange.upperBound)
    }
}
