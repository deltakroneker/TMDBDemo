//
//  NavigationControllerRouterTest.swift
//  TMDBDemoTests
//
//  Created by nikolamilic on 10/7/23.
//

import XCTest
@testable import TMDBDemo

final class NavigationControllerRouterTest: XCTestCase {
    func test_onStart_showsTabBarControllerWithTopRatedMoviesScreenInsideNavigationController() {
        let tabBarController = UITabBarController()
        let topRatedMoviesVC = UIViewController()
        self.factory.stubTopRatedMoviesVC(with: topRatedMoviesVC)
        let sut = NavigationControllerRouter(tabBarController, factory: self.factory, dispatchQueue: self.dispatchQueue)

        sut.start()

        XCTAssert(tabBarController.children.first is UINavigationController)
        XCTAssert((tabBarController.children.first as! UINavigationController).viewControllers.first == topRatedMoviesVC)
    }
    
    // Helpers:
    
    private let factory = ViewControllerFactoryStub()
    private let dispatchQueue = DispatchFake()
    
    private class NonAnimatedNavigationController: UINavigationController {
        override func pushViewController(_ viewController: UIViewController, animated: Bool) {
            super.pushViewController(viewController, animated: false)
        }
    }
    
    private class DispatchFake: Dispatching {
        func async(execute workItem: DispatchWorkItem) {
            workItem.perform()
        }
    }
    
    private class ViewControllerFactoryStub: ViewControllerFactory {
        private var stubbedTopRatedMoviesVC: UIViewController?
        
        func stubTopRatedMoviesVC(with viewController: UIViewController) {
            stubbedTopRatedMoviesVC = viewController
        }
        
        // Factory protocol
        
        func topRatedMoviesScreen(movieTapAction: @escaping (TMDBDemo.Movie) -> Void) -> UIViewController {
            return stubbedTopRatedMoviesVC ?? UIViewController()
        }
        
    }
}
