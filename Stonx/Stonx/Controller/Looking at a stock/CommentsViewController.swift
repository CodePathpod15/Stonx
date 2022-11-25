import MessageInputBar
import Parse
import UIKit

class CommentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MessageInputBarDelegate {
   
    let commentBar = MessageInputBar()
    
    // this contains all of the comments
    var comments = [Comment]()
    var selectedStock = [PFObject]()
    private var showsCommentBar = false
    var stockName = ""
    
    let tableView: AutoSizingTableView = {
        let table = AutoSizingTableView()
        table.register(CommentTableViewCell.self, forCellReuseIdentifier: CommentTableViewCell.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        Comments.shared.gettingComments(stockName: stockName) { result in
            switch result {
            case .success(let commentsss):
                print(commentsss)
                self.comments = commentsss
                self.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
    private func setUpViews() {
        let backButton = UIBarButtonItem()
        let addCommentButton = UIBarButtonItem(image: UIImage(systemName: "plus.bubble.fill"), style: .plain, target: self, action: #selector(addComment))
        navigationItem.rightBarButtonItem = addCommentButton
        backButton.title = "Back"
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        commentBar.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        tableView.keyboardDismissMode = .interactive
        
        commentBar.sendButton.title = "Post"
        commentBar.inputTextView.placeholder = "Post a comment..."
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(hideKeyboard(note:)), name: UIResponder.keyboardWillHideNotification, object: nil)

        view.addSubview(tableView)
        
        tableView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
    }
    
    @objc func addComment() {
        showsCommentBar = true
        becomeFirstResponder()
        commentBar.inputTextView.becomeFirstResponder()
    }
    
    @objc func hideKeyboard(note: Notification) {
        commentBar.inputTextView.text = nil
        showsCommentBar = false
        becomeFirstResponder()
    }
    
    func messageInputBar(_ inputBar: MessageInputBar, didPressSendButtonWith text: String) {
        // Create the comment
        Comments.shared.creatingAComment(with: text) { result in
            switch result {
            case .success(let comment):
                self.comments.append(comment)
                self.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        // Clear and dismiss the input bar
        commentBar.inputTextView.text = nil
        showsCommentBar = false
        becomeFirstResponder()
        commentBar.inputTextView.resignFirstResponder()
    }

    override var inputAccessoryView: UIView? {
        return commentBar
    }

    override var canBecomeFirstResponder: Bool {
        return showsCommentBar
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return comments.count
    }
    
    // indexpath
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CommentTableViewCell.identifier) as! CommentTableViewCell
        cell.configure(comment: comments[indexPath.row])
        
        return cell
    }
}
