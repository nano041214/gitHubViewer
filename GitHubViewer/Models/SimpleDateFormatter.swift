import Foundation

class SimpleDateFormatter: NSDateFormatter {
    private static var simpleDateFormatter: NSDateFormatter?

    static func dateFomatter() -> NSDateFormatter {
        guard let simpleDateFormatter = self.simpleDateFormatter else {
            let dateFormatter: NSDateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return dateFormatter
        }
        return simpleDateFormatter
    }
}
