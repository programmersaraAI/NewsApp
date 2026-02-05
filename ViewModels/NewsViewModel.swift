class NewsViewModel {

    private(set) var articles: [Article] = []

    var onDataUpdate: (() -> Void)?
    var onError: ((String) -> Void)?

    func fetchNews() {
        NetworkManager.shared.fetchArticles { [weak self] result in
            switch result {
            case .success(let data):
                self?.articles = data
                self?.onDataUpdate?()

            case .failure(let error):
                self?.onError?(error.localizedDescription)
            }
        }
    }

    func numberOfArticles() -> Int {
        articles.count
    }

    func article(at index: Int) -> Article {
        articles[index]
    }
}
