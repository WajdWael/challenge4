import Foundation
import SwiftData

//child info will be stored using swift sata
@Model
class Child : ObservableObject{
    var age : String
    var currentWordIndex: Int
   var currentLevelPrograss : Int
    
    
    var currentLetterIndex: Int
    //var completedWords: [Bool]
   
    init(age: String, currentWordIndex: Int, currentLevelPrograss : Int, currentLetterIndex:Int){
        self.age = age
        self.currentWordIndex = currentWordIndex
        self.currentLevelPrograss = currentLevelPrograss
        self.currentLetterIndex = currentLetterIndex
        //self.completedWords = completedWords
    }
}
