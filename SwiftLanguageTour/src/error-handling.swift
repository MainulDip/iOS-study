/*
* You represent errors using any type that adopts the Error protocol.
* Use throw to throw an error and throws to mark a function that can throw an error. If you throw an error in a function, the function returns immediately and the code that called the function handles the error.
*/

    enum PrinterError: Error {
        case outOfPaper
        case noToner
        case onFire
    }

    func send(job: Int, toPrinter printerName: String) throws -> String {
        if printerName == "Never Has Toner" {
            throw PrinterError.noToner
        }
        return "Job sent"
    }

    do {
        let printerResponse = try send(job: 1040, toPrinter: "Bi Sheng")
        print(printerResponse)
    } catch {
        print(error)
    }
    // Prints "Job sent"
