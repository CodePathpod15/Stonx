import UIKit

//TODO: ignore

class sampleVC1:UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
}

class sampleVC2: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
}

class sampleVC3: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
    }
}

class sampleVC4: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }
}



class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: add your viewcontroller here 
        let home = UINavigationController(rootViewController: UserDashboardViewController())
        let favorites = UINavigationController(rootViewController: WatchListViewController())
        let search = UINavigationController(rootViewController: SearchStocksViewController())
        let profile = UINavigationController(rootViewController: SettingsViewcontrollerViewController())
        
        home.title = "Home"
        favorites.title = "Favorites"
        search.title = "Search"
        profile.title = "Profile"
        
        
        //Logos grabbed from SF Symbols
        home.tabBarItem.image = UIImage(systemName: "chart.bar.xaxis")
        favorites.tabBarItem.image = UIImage(systemName: "tray.full")
        search.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        profile.tabBarItem.image = UIImage(systemName: "person")
        
        tabBar.tintColor = .label
        tabBar.tintColor = ColorConstants.green
//        tabBar.isTranslucent = false
         
        
        
        
        
        setViewControllers([home,favorites,search,profile], animated: true)
    }
}
