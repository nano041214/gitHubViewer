enum GitHubViewerError: ErrorType {
    case NoSuchUser
    case UnExpectedResponce(message: String)
    case UnknownError

    var errorDescription: String {
        switch self {
        case .NoSuchUser:
            return "No such user here."
        case .UnExpectedResponce(message: let message):
            return message
        case .UnknownError:
            return "Unknown error occurd."
        }
    }
}
