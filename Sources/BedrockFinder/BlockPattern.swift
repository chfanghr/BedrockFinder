//
// BlockPattern.swift
//
// Created by 方泓睿 on 2022/1/30.
//

public typealias BlockPattern = [[[Block?]]]

public func emptyPattern(x: Int, z: Int, y: Int) -> BlockPattern {
    let column: [Block?] = Array(repeating: nil, count: x)
    let rows: [[Block?]] = Array(repeating: column, count: z)
    let layers: [[[Block?]]] = Array(repeating: rows, count: y)
    return layers
}

public let threeByThreeBedrockPattern: BlockPattern =
        [[[.bedrock, .bedrock, .bedrock],
          [.bedrock, .bedrock, .bedrock],
          [.bedrock, .bedrock, .bedrock]]]