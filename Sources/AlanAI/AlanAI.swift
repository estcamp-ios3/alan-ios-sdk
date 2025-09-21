import Foundation

public struct AlanResponse: Codable {
    public var action: Action?
    public var content: String?
}

public struct Action: Codable {
    public var name: String?
    public var speak: String?
}

public enum AlanAIError: Error {
    case invalidRequest
    case noServerResponse
    case unknown
}

@available(iOS 15.0, *)
@available(macOS 12.0, *)
@available(tvOS 15.0, *)
@available(visionOS 26.0, *)
public struct AlanAI {

    private var clientID: String?
    
    private let apiURLPrefix: String = "https://kdt-api-function.azurewebsites.net/api/v1/"
    
    public init(clientID: String? = nil) {
        self.clientID = clientID
    }
    
    public func question(query: String) async throws -> AlanResponse? {
        
        guard !query.isEmpty else {
            throw AlanAIError.invalidRequest
        }
        
        guard let queryEncoded = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            throw AlanAIError.invalidRequest
        }
        
        let apiUrlString: String = apiURLPrefix + "question?client_id=\(clientID ?? "")&content=\(queryEncoded)"
        
        guard let apiUrl = URL(string: apiUrlString) else {
            throw AlanAIError.invalidRequest
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: apiUrl)
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                throw AlanAIError.unknown
            }
            
            return try JSONDecoder().decode(AlanResponse.self, from: data)
        } catch {
            throw AlanAIError.unknown
        }
    }
    
    /*
    public func questionStream(query: String, streamHandler: @escaping (AlanResponse) -> Void) async throws {
        
        let apiUrlString: String = apiURLPrefix + "question/sse-streaming"
    }
    */
    
}
