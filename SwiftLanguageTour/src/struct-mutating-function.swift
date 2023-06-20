protocol baseProtocol {
    // if protocol states the mutating keyword, inherited method does not need to be prefixed with mutating
    mutating func getNextQuestion() -> Int
}

class QuestionStore : baseProtocol {

    var currentQuestion = 0

    // Inherited method inside class does not need the mutating keyword
    func getNextQuestion() -> Int {
        currentQuestion += 1
        return currentQuestion
    }
}

var qs = QuestionStore()
print(qs.getNextQuestion(), qs.getNextQuestion())

// prints => 1 2