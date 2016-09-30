enum GitHubViewerError: ErrorType {
    case NoSuchUser
    case UnExpectedResponse(message: String)
    case UnknownError

    var errorDescription: String {
        switch self {
        case .NoSuchUser:
            return "No such user here."
        case .UnExpectedResponse(message: let message):
            return message
        case .UnknownError:
            return "Unknown error occurd."
        }
    }
}
