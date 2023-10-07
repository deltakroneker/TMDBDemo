//
//  AppDelegate.swift
//  TMDBDemo
//
//  Created by nikolamilic on 10/6/23.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    private lazy var tabBarController = UITabBarController()
    private var router: NavigationControllerRouter!
    let genresService = GenresService(loader: TMDBGenreLoader(client: iOSSwiftUIViewControllerFactory.createAuthenticatedHTTPClient()))

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()

        router = NavigationControllerRouter(tabBarController, factory: iOSSwiftUIViewControllerFactory(genresService: genresService))
        router.start()
        
        return true
    }
}
