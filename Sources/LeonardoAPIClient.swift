import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

public struct LeonardoAPIClient {
    private let apiKey: String
    public let client: Client

    public init(apiKey: String) throws {
        self.apiKey = apiKey
        self.client = Client(
            serverURL: try Servers.Server1.url(),
            transport: URLSessionTransport(),
            middlewares: [AuthMiddleware(apiKey: apiKey)]
        )
    }
}
