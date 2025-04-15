//
//  GeminiAPI.swift
//  Shopping List
//
//  Created by Gustavo Yud on 26/03/25.
//

import Foundation
import GoogleGenerativeAI
import UIKit

class GenerativeAPI {
    static let shared = GenerativeAPI()
    private var model = GenerativeModel(name: "gemini-2.0-flash", apiKey: APIKey.default)
    
    func generateText(prompt: String, image: UIImage? = nil) async -> String {
        do {
            let response: GenerateContentResponse
            if let image = image {
               response = try await model.generateContent(prompt, image)
            } else {
               response = try await model.generateContent(prompt)
            }
            guard let text = response.text else {
                return ""
            }
            return text
        } catch {
            print("Error: \(error)")
            return ""
        }
    }

}


