class NewsCell: UITableViewCell {

    static let identifier = "NewsCell"

    func configure(with article: Article) {
        textLabel?.text = article.title
        detailTextLabel?.text = article.body
        detailTextLabel?.numberOfLines = 2
    }
}
