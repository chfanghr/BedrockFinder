//
//  misc.swift
//  
//
//  Created by 方泓睿 on 2022/1/30.
//

internal func javaStringHash(_ str: String) -> Int32 {
    str.utf16.reduce(0) { res, ch in
        31 &* res &+ Int32(ch)
    }
}

internal func normalize(x: Float64, zero: Float64, one: Float64) -> Float64 {
    (x - zero) / (one - zero)
}

public typealias ReportFunc<T> = (T?, /*count*/ UInt64, /*total*/ UInt64) -> Void

internal class CounterBox{
    var counter: UInt64 = 0
}

internal func makeReportFuncWrapper<T>(from a: Point, to b: Point ,
                                      _ ctx: T?,
                                      _ reportFunc: ReportFunc<T>?) -> () -> Void {
    guard let cb = reportFunc else{
        return {}
    }

    let total = Point.area(from: a, to: b)
    let counter = CounterBox()

    return {
        counter.counter += 1
        cb(ctx, counter.counter, total)
    }
}