import MessageInputBar
import Parse
import UIKit

class CommentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MessageInputBarDelegate {
    let comments = [PFObject]()
    let commentBar = MessageInputBar()
    var selectedStock = [PFObject]()
    private var showsCommentBar = false
    var stockName = ""
    
    let tableView: UITableView = {
        let table = UITableView()
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
        let stock = PFObject(className: "Stocks")
        let query = PFQuery(className: "Stocks")
        query.whereKey("symbol", equalTo: stockName)
        query.includeKeys(["Comments", "Comments.author"])
        // The query should only find one match as every stock will be unique
        query.findObjectsInBackground { result, _ in
            if result != nil {
                self.selectedStock = result!
                
                // If the stock entry hasn't been made, make the entry and save it as the current stock
                if self.selectedStock.count == 0 {
                    stock["symbol"] = self.stockName
                    stock["comments"] = [PFObject]()
                    stock.saveInBackground { success, error in
                        if success {
                            query.findObjectsInBackground { result, _ in
                                if result != nil {
                                    self.selectedStock = result!
                                }
                            }
                            print("SAVING DATA SUCCESSFUL")
                        }
                        else {
                            print("ERROR: \(String(describing: error?.localizedDescription))")
                        }
                    }
                }
                self.tableView.reloadData()
            }
            else {
                print("QUERY RETURNED NULL")
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
        let comment = PFObject(className: "comments")
        let stock = selectedStock.first!
        comment["text"] = text
        comment["author"] = PFUser.current()!
        comment["stock"] = stock

        stock.add(comment, forKey: "Comments")
        stock.saveInBackground { success, error in
            if success {
                print("Comment successful")
            }
            else {
                print("Comment error: \(String(describing: error?.localizedDescription))")
            }
        }
        tableView.reloadData()

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
        if let stock = selectedStock.first {
            let comments = (stock["Comments"] as? [PFObject]) ?? []
            return comments.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CommentTableViewCell.identifier) as! CommentTableViewCell
        
        if let stock = selectedStock.first {
            let comments = (stock["Comments"] as? [PFObject]) ?? []
            
            let profile = comments[indexPath.row]["author"] as! PFUser
            
            let comment = comments[indexPath.row]["text"] as! String
            
            cell.configure(username: profile.username!, comment: comment)
        }
        
        return cell
    }
}
