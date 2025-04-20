enum EntropyError: Error {
    case entropyDepleted
}


struct UnreliableRandomGenerator {
    func random() throws -> Int {
        if Bool.random() {
            return Int.random(in: 1...100)
        } else {
            throw EntropyError.entropyDepleted
        }
    }
}

struct RandomnessMonitor {
    let randomnessSource: UnreliableRandomGenerator
    var results: [Result<Int, Error>] = []


    init(generator: UnreliableRandomGenerator) {
        randomnessSource = generator
    }


    mutating func sample() {
        let sample = Result { try randomnessSource.random() }
        results.append(sample)
    }


    func summary() -> (Double, Double) {
        let totals = results.reduce((sum: 0, count: 0)) { total, sample in
            switch sample {
            case .success(let number):
                return (total.sum + number, total.count)
            case .failure:
                return (total.sum, total.count + 1)
            }
        }


        return (
            average: Double(totals.sum) / Double(results.count - totals.count),
            failureRate: Double(totals.count) / Double(results.count)
        )
    }
}

var monitor = RandomnessMonitor(generator: UnreliableRandomGenerator())
(0..<1000).forEach { _ in monitor.sample() }
let (average, failureRate) = monitor.summary()
print("Average value: \(average), failure rate: \(failureRate * 100.0)%.")
// Prints values such as: "Average value: 47.95, failure rate: 48.69%."