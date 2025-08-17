import SwiftData

//#1
@Model

//#2
class Wish {
    var title: String
    
//#3
    init(title: String) {
        self.title = title
    }
}


