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
    
    print(reduced)
    print(reducedTuple)
    print(reducedTupleNoParamName)
    /*
     10
     (leftP: 6, rightP: 60)
     (6, 60)
     */
}
