import Foundation

struct TriviaResponse: Codable {
    let results: [TriviaQuestion]
}

struct TriviaQuestion: Codable, Identifiable, Hashable {
    var id: String { question }
    let category: String
    let type: String
    let difficulty: String
    let question: String
    let correctAnswer: String
    let incorrectAnswers: [String]
    
    let allAnswers: [String]
    
    enum CodingKeys: String, CodingKey {
        case category, type, difficulty, question
        case correctAnswer = "correct_answer"
        case incorrectAnswers = "incorrect_answers"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        category = try container.decode(String.self, forKey: .category)
        type = try container.decode(String.self, forKey: .type)
        difficulty = try container.decode(String.self, forKey: .difficulty)
        question = try container.decode(String.self, forKey: .question)
        correctAnswer = try container.decode(String.self, forKey: .correctAnswer)
        incorrectAnswers = try container.decode([String].self, forKey: .incorrectAnswers)
        // needed to prevent answers 'shuffling' everytime the timer counts down.
        allAnswers = (incorrectAnswers + [correctAnswer]).shuffled()
    }
}

extension String {
    var decoded: String {
        var result = self
        let htmlEntities: [String: String] = [
            "&amp;": "&",
            "&lt;": "<",
            "&gt;": ">",
            "&quot;": "\"",
            "&#039;": "'",
            "&apos;": "'",
            "&ndash;": "–",
            "&mdash;": "—",
            "&nbsp;": " ",
            "&eacute;": "é",
            "&egrave;": "è",
            "&agrave;": "à",
            "&uuml;": "ü",
            "&ouml;": "ö",
            "&auml;": "ä"
        ]
        for (entity, char) in htmlEntities {
            result = result.replacingOccurrences(of: entity, with: char)
        }
        return result
    }
}
