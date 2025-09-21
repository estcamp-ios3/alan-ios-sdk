//
//  ContentView.swift
//  AlanAIExample
//
//  Created by Ned Park on 9/21/25.
//

import SwiftUI
import AlanAI

struct ContentView: View {
    @State private var contextList: [AttributedString] = []
    @State private var prompt: String = "오늘 서울 날씨 어때?"
    
    var body: some View {
        VStack {
            List(contextList, id: \.self) { text in
                Text(text)
            }
            .listStyle(.plain)
            
            Divider()
            
            HStack {
                TextField("Prompt", text: $prompt)
                    .lineLimit(5)
                Button("Send") {
                    Task {
                        await sendPrompt()
                    }
                }
            }
            .padding()
        }
    }
    
    private func sendPrompt() async {
        
        contextList.append(attributedString("**\(prompt)**"))
        contextList.append(attributedString("(응답 생성중...)"))
        
        let clientId = "(여러분의 key)"
        let alanAI = AlanAI(clientID: clientId)
        
        do {
            let response: AlanResponse? = try await alanAI.question(query: prompt)
            
            if let response {
                contextList.removeLast(1)
                contextList.append(attributedString(response.content ?? "(none)"))
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func attributedString(_ text: String) -> AttributedString {
        let attributed = try! AttributedString(
            markdown: text,
            options: .init(interpretedSyntax: .inlineOnlyPreservingWhitespace)
        )
        
        return attributed
    }
}

#Preview {
    ContentView()
}
