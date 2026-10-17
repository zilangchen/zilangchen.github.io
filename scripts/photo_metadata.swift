import Foundation
import ImageIO

guard CommandLine.arguments.count == 3 else { fatalError("Usage: swift photo_metadata.swift SOURCE PRIVATE_REPORT") }
let source = URL(fileURLWithPath: CommandLine.arguments[1], isDirectory: true).standardizedFileURL
let output = URL(fileURLWithPath: CommandLine.arguments[2])
guard let enumerator = FileManager.default.enumerator(at: source, includingPropertiesForKeys: [.isRegularFileKey], options: [.skipsHiddenFiles]) else { fatalError("Cannot read source folder") }
let urls = enumerator.compactMap { $0 as? URL }.filter { ["jpg", "jpeg", "png", "heic", "heif", "raf", "dng"].contains($0.pathExtension.lowercased()) }.sorted { $0.path < $1.path }

var records = [[String: Any]]()
for url in urls {
    var record: [String: Any] = ["file": String(url.path.dropFirst(source.path.count + 1)), "type": url.pathExtension.lowercased()]
    guard let image = CGImageSourceCreateWithURL(url as CFURL, nil), let properties = CGImageSourceCopyPropertiesAtIndex(image, 0, nil) as? [String: Any] else {
        record["error"] = "ImageIO could not read original image metadata"
        records.append(record)
        continue
    }
    let exif = properties[kCGImagePropertyExifDictionary as String] as? [String: Any] ?? [:]
    if let date = exif[kCGImagePropertyExifDateTimeOriginal as String] { record["capture_time"] = date }
    if let gps = properties[kCGImagePropertyGPSDictionary as String] as? [String: Any] {
        record["gps_keys"] = gps.keys.sorted()
        if let lat = gps[kCGImagePropertyGPSLatitude as String] as? NSNumber, let lon = gps[kCGImagePropertyGPSLongitude as String] as? NSNumber {
            let latRef = gps[kCGImagePropertyGPSLatitudeRef as String] as? String ?? ""
            let lonRef = gps[kCGImagePropertyGPSLongitudeRef as String] as? String ?? ""
            let latitude = lat.doubleValue * (latRef == "S" ? -1 : 1)
            let longitude = lon.doubleValue * (lonRef == "W" ? -1 : 1)
            if abs(latitude) <= 90 && abs(longitude) <= 180 && (latitude != 0 || longitude != 0) && ["N", "S"].contains(latRef) && ["E", "W"].contains(lonRef) {
                record["latitude"] = latitude
                record["longitude"] = longitude
            } else { record["gps_warning"] = "Coordinates or hemisphere references are incomplete" }
        }
    }
    records.append(record)
}
let data = try JSONSerialization.data(withJSONObject: records, options: [.prettyPrinted, .sortedKeys])
try data.write(to: output, options: .atomic)
let summary: [String: Any] = ["files": records.count, "with_gps": records.filter {$0["latitude"] != nil}.count, "errors": records.filter {$0["error"] != nil}.count]
let summaryData = try JSONSerialization.data(withJSONObject: summary, options: [.sortedKeys])
print(String(data: summaryData, encoding: .utf8)!)
