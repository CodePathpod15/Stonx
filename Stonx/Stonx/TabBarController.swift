import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let home = UINavigationController(rootViewController: UserDashboardViewController())
        let favorites = UINavigationController(rootViewController: WatchListViewController())
        let search = UINavigationController(rootViewController: SearchStocksViewController())
        let profile = UINavigationController(rootViewController: ProfileViewController())
        
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
        
        
        setViewControllers([home,favorites,search,profile], animated: true)
    }
}
