import Foundation

// Генерирует тело в формате x-www-form-urlencoded из массива значений с одинаковым ключом
func urlEncodedArray(key: String, values: [String]) -> Data? {
    var components = URLComponents()
    components.queryItems = values.map { URLQueryItem(name: key, value: $0) }
    return components.percentEncodedQuery?.data(using: .utf8)
}
