//
// PatternFinder.swift
//
//
// Created by 方泓睿 on 2022/1/30.
//

public struct PatternFinder {
    // Layers along Y, rows along Z, columns along X
    public let bedrockPattern: BlockPattern

    public let generator: GradientGenerator

    public func searchAll<T>(from a: Point, to b:Point,
                             _ ctx: T? = nil,
                             _ onMakingProgress: ((T?, /*count*/ UInt64, /*total*/ UInt64) -> Void)? = nil
    ) -> [Point]{
        let cb = makeReportFuncWrapper(from: a, to: b, ctx, onMakingProgress)

        return Point.iter(from: a, to: b).filter{ p in
            cb()

            return check(p)
        }
    }

    public func search<T>(from a: Point, to b:Point,
                       _ ctx: T? = nil,
                       _ onMakingProgress: ReportFunc<T>? = nil
                       ) -> Point? {

        let cb = makeReportFuncWrapper(from: a, to: b, ctx, onMakingProgress)

        return Point.iter(from: a, to: b).first{ p in
            cb()

            return check(p)
        }
    }

    // TODO: speed things up
    private func check(_ p: Point) -> Bool {
        for (py, layer) in bedrockPattern.enumerated() {
            for (pz, row) in layer.enumerated() {
                for (px, block) in row.enumerated() {
                    if let block = block{
                        let blockAt = generator.at(
                                x: p.x + Int32(px),
                                y: p.y + Int32(py),
                                z: p.z + Int32(pz))
                        guard block == blockAt else{
                            return false
                        }
                    }
                }
            }
        }
        return true
    }
}