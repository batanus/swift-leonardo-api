import Foundation
import OpenAPIRuntime
import OpenAPIURLSession
import HTTPTypes


final class AuthMiddleware: ClientMiddleware {
    private let apiKey: String
    init(apiKey: String) {
        self.apiKey = apiKey
    }

    func intercept(
        _ request: HTTPRequest,
        body: HTTPBody?,
        baseURL: URL,
        operationID: String,
        next: @Sendable (HTTPRequest, HTTPBody?, URL) async throws -> (HTTPResponse, HTTPBody?)
    ) async throws -> (HTTPResponse, HTTPBody?) {
        var request = request
        request.headerFields.append(.init(name: .authorization, value: "Bearer: \(apiKey)"))
        return try await next(request, body, baseURL)
    }
}


let apiKey = "test"
let client = Client(
    serverURL: try Servers.Server1.url(),
    transport: URLSessionTransport(),
    middlewares: [AuthMiddleware(apiKey: apiKey)]
)
