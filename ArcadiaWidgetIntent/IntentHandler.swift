//
//  IntentHandler.swift
//  ArcadiaWidgetIntent
//
//  Created by Ravi Tripathi on 08/08/21.
//

import Intents

// As an example, this class is set up to handle Message intents.
// You will want to replace this or add other intents as appropriate.
// The intents you wish to handle must be declared in the extension's Info.plist.

// You can test your example integration by saying things to Siri like:
// "Send a message using <myApp>"
// "<myApp> John saying hello"
// "Search for messages in <myApp>"

class IntentHandler: INExtension, GitBrowserIntentHandling {
    func resolveUsername(for intent: GitBrowserIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
        guard let username = intent.username else {
            completion(INStringResolutionResult.confirmationRequired(with: nil))
            return
        }
        completion(INStringResolutionResult.success(with: username))
    }
    
    
}
