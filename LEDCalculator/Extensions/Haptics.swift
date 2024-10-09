//
//  Haptics.swift
//  KBDCalc
//
//  Created by Wayne Dahlberg on 3/4/24.
//

import Foundation

//Button(action: {
//    let impactMed = UIImpactFeedbackGenerator(style: .medium)
//    impactMed.impactOccurred()
//}) {
//    Text("This is a Button")
//}

/* You can replace `.medium` with:
    .soft
    .light
    .heavy
    .rigid
    
    Or when tapping any view:
    .onTapGesture {
        let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)
        impactHeavy.impactOccurred()
    }
    
    Or when long-pressing
    .onLongPressGesture {
        let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)
        impactHeavy.impactOccurred()
    }

*/


// Encapsulate Haptic into a Singleton
import UIKit

class Haptics {
    static let shared = Haptics()
    
    private init() { }

    func play(_ feedbackStyle: UIImpactFeedbackGenerator.FeedbackStyle) {
        UIImpactFeedbackGenerator(style: feedbackStyle).impactOccurred()
    }
    
    func notify(_ feedbackType: UINotificationFeedbackGenerator.FeedbackType) {
        UINotificationFeedbackGenerator().notificationOccurred(feedbackType)
    }
}

// and at the callsite:

//// As a button action
//Button(action: {
//    // some action
//    Haptics.shared.play(.heavy)
//}, label: {
//    Text("Button")
//})
//
//// As a tap gesture on a View
//SomeView()
//.onTapGesture(perform: {
//    Haptics.shared.play(.light)
//})
//
//// In a function
//func someFunc() {
//    Haptics.shared.notify(.success)
//}

/* options:

Haptics.shared.play(.heavy)
Haptics.shared.play(.light)
Haptics.shared.play(.medium)
Haptics.shared.play(.rigid)
Haptics.shared.play(.soft)
                
Haptics.shared.notify(.error)
Haptics.shared.notify(.success)
Haptics.shared.notify(.warning)

*/
