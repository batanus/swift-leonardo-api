import OpenAPIRuntime
import HTTPTypes
import Foundation

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
