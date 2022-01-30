//
// Point.swift
//
//
// Created by 方泓睿 on 2022/1/30.
//

import Foundation

public struct Point {
    public let x: Int32
    public let y: Int32
    public let z: Int32

    public init(x: Int32, y: Int32, z: Int32) {
        self.x = x
        self.y = y
        self.z = z
    }

    static func iter(from a: Point, to b: Point) -> PointRange {
        PointRange(start: a, end: b)
    }

    static func area(from a: Point, to b: Point) -> UInt64 {
        UInt64(abs(a.x - b.x)) * UInt64(abs(a.y - b.y)) * UInt64(abs(a.z - b.z))
    }

    private func setX(_ x: Int32) -> Point {
        Point(x: x, y: y, z: z)
    }

    private func setY(_ y: Int32) -> Point {
        Point(x: x, y: y, z: z)
    }

    private func setZ(_ z: Int32) -> Point {
        Point(x: x, y: y, z: z)
    }

    internal struct PointRange: Sequence {
        let start: Point
        let end: Point

        class Iterator: IteratorProtocol {
            var pos: Point

            let start: Point
            let end: Point

            init(start: Point, end: Point) {
                self.pos = start
                self.start = start
                self.end = end
            }

            func next() -> Point? {
                if pos.y >= end.y - 1 {
                    pos = pos.setY(start.y)
                    if pos.x >= end.x - 1 {
                        pos = pos.setX(start.x)
                        if pos.z >= end.z - 1 {
                            return nil
                        } else {
                            pos = pos.setZ(pos.z + 1)
                        }
                    } else {
                        pos = pos.setX(pos.x + 1)
                    }
                } else {
                    pos = pos.setY(pos.y + 1)
                }
                return pos
            }
        }

        func makeIterator() -> Iterator {
            Iterator(start: start, end: end)
        }
    }
}