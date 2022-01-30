//
//  FixedWidthInteger+CircularShift.swift
//  
//
//  Created by 方泓睿 on 2022/1/30.
//

import Foundation

infix operator <<<: BitwiseShiftPrecedence
infix operator >>>: BitwiseShiftPrecedence

internal extension FixedWidthInteger {
    @inlinable @inline(__always)
    static func <<<<RHS: BinaryInteger>(lhs: Self, rhs: RHS) -> Self {
        lhs &<< rhs | lhs &>> (Self.bitWidth &- Int(rhs))
    }

    @inlinable @inline(__always)
    static func >>><RHS: BinaryInteger>(lhs: Self, rhs: RHS) -> Self {
        lhs &>> rhs | lhs &<< (Self.bitWidth &- Int(rhs))
    }
}
