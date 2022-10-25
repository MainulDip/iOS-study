/*
* Basic Subscripts
* define in class/struct using "subscript (param: type) -> return-type { body }"
* call on newInstance[value]
*/

struct TimesTable {
    let multiplier: Int
    subscript(index: Int) -> Int {
        return multiplier * index
    }
}
let threeTimesTable = TimesTable(multiplier: 3)
print("seven times three is \(threeTimesTable[7])") // prints "seven times three is 21"

print("\nSubscript Example 2 -------------------------------\n")

    struct Matrix {
        let rows: Int, columns: Int
        var grid: [Double]
        init(rows: Int, columns: Int) {
            self.rows = rows
            self.columns = columns
            grid = Array(repeating: 0.0, count: rows * columns)
        }

        func indexIsValid(row: Int, column: Int) -> Bool {
            return row >= 0 && row < rows && column >= 0 && column < columns
        }

        subscript(row: Int, column: Int) -> Double {
            get {
                assert(indexIsValid(row: row, column: column), "Index out of range")
                return grid[(row * columns) + column]
            }
            set {
                assert(indexIsValid(row: row, column: column), "Index out of range")
                grid[(row * columns) + column] = newValue
            }
        }
    }

    var d = Array(repeating: 0, count: 4)
    print(d)
    var matrix = Matrix(rows: 2, columns: 2)
    print(matrix.grid)
    // print("\(matrix.indexIsValid(row: 1, column: 1))")
    // print("\(matrix[1, 2])")

    // Setting Matrix Value
    print("\nSetting Matrix Value With Inspections Print\n")
    
    matrix[0, 1] = 1.5
    matrix[1, 0] = 3.2
    print(matrix.grid)
    // [0.0, 1.5, 
    // 3.2000000000000002, 0.0]

/*
1 indexing matrix | total rows * total columns = last slot
1 indexing matrix | row number * total columns = last slot of that row

0 indexing matrix | total rows  * total columns - 1 = last slot
0 indexing matrix | row number * total columns = first slot of that row

0   1   2
3   4   5
6   7   8
9   10  11 

3 * 3 - 1 = last slot of third row (0 indexing)
2 * 3 = first slot of the third row (0 indexing)
*/