class NewsVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    private let viewModel = NewsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "News"
        setupTableView()
        bindViewModel()
        viewModel.fetchNews()
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }

    private func bindViewModel() {
        viewModel.onDataUpdate = { [weak self] in
            self?.tableView.reloadData()
        }

        viewModel.onError = { [weak self] message in
            self?.showAlert(message: message)
        }
    }

    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error",
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
extension NewsVC: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",
                                                 for: indexPath)
        cell.textLabel?.text = "خبر رقم \(indexPath.row)"
        return cell
    }
}
