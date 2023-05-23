//
//  Quation.swift
//  PersonalQuiz
//
//  Created by Кирилл Слюсарь on 17.05.2023.
//

struct Quation {
    let title: String
    let responseType : ResponseType
    let answers : [Answer]
    
    static func getQuation() -> [Quation] {
        [
            Quation(title: "Какую пищу вы предпочитаете",
                    responseType: .single,
                    answers: [
                    Answer (title: "Стейк", animal: .dog),
                    Answer (title: "Рыба", animal: .cat),
                    Answer (title: "Морковь", animal:.rabbit),
                    Answer (title: "Кукуруза", animal: .turtle),
                    ]
                ),
                    
                    Quation(title: "Что вам больше нравится?",
                            responseType: .multiple,
                            answers: [
                            Answer (title: "Плавать", animal: .dog),
                            Answer (title: "Спать", animal: .cat),
                            Answer (title: "Обниматься", animal:.rabbit),
                            Answer (title: "Есть", animal: .turtle),
                            ]
                           ),
                            
                            Quation(title: "Любите ли вы кататься на машине?",
                                    responseType: .range,
                                    answers: [
                                    Answer (title: "Ненавижу", animal: .turtle),
                                    Answer (title: "Нервничаю", animal: .rabbit),
                                    Answer (title: "Незамечаю", animal:.cat),
                                    Answer (title: "Обожаю", animal: .dog),
                                    ]
                )
            ]
    }
}

enum ResponseType {
    case single
    case multiple
    case range
}

struct Answer {
    let title : String
    let animal : Animal
}

enum Animal : Character {
    case dog = "🐶"
    case cat = "🐱"
    case rabbit = "🐰"
    case turtle = "🐢"
    
    var definition: String {
        switch self {
            
        case .dog:
            return "Вам нравится быть с друзьями"
        case .cat:
            return "Вы себе на уме"
        case .rabbit:
            return "Вам нравится все мягкое"
        case .turtle:
            return "Ваша сила в мудрости"
        }
    }
}
