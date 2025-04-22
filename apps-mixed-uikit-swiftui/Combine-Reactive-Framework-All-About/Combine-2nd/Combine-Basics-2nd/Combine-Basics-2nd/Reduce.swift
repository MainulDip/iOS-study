//
//  Reduce.swift
//  Combine-Basics-2nd
//
//  Created by Mainul Dip on 4/19/25.
//

import Foundation

func reducing() {
    let arr = [1, 2, 3, 4]
    let reduced = arr.reduce(0) { result, element in
        return result + element
    }
    
    let arrTuple = [(1, 10), (2, 20), (3, 30)]
    let reducedTuple = arrTuple.reduce((leftP: 0, rightP: 0)) { tup, arr in
        let left = tup.leftP + arr.0
        let right = tup.rightP + arr.1
        return (left, right)
    }
    
    let reducedTupleNoParamName = arrTuple.reduce((0, 0)) { tup, arr in
        let left = tup.0 + arr.0
        let right = tup.1 + arr.1
        return (left,right)
    }
    
    let reducedUsingIntoParameter = arrTuple.reduce(into: (0, 0)) { result, element in
        let left = result.0 + element.0
        let right = result.1 + element.1
        result = (left, right)
    }
    
    
    let _ = arr.reduce(0, +) // return 10 // using shorthand syntax
    // here the `+` is an function and it matches perfectly with the `updateAccumulatingResult` param's function signature
    
    print(reduced)
    print(reducedTuple)
    print(reducedTupleNoParamName)
    print("reducedUsingIntoParameter: \(reducedUsingIntoParameter)")
    /*
     10
     (leftP: 6, rightP: 60)
     (6, 60)
     reducedUsingIntoParameter: (6, 60)
     */
}
