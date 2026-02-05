class NetworkManager {

    static let shared = NetworkManager()
    private init() {}

    private let urlString = "https://jsonplaceholder.typicode.com/posts"

    func fetchArticles(completion: @escaping (Result<[Article], NetworkError>) -> Void) {

        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, _ in

            guard let data = data else {
                completion(.failure(.noData))
                return
            }

            do {
                let articles = try JSONDecoder().decode([Article].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(articles))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(.decodingError))
                }
            }

        }.resume()
    }
}
