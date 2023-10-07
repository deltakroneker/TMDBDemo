//
//  iOSSwiftUIViewControllerFactoryTest.swift
//  TMDBDemoTests
//
//  Created by nikolamilic on 10/7/23.
//

import XCTest
import SwiftUI
@testable import TMDBDemo

final class iOSSwiftUIViewControllerFactoryTest: XCTestCase {
    func test_topRatedMoviesScreen_createsControllerWithTopRatedViewAsRootView() {
        let sut = iOSSwiftUIViewControllerFactory()
        let controller = sut.topRatedMoviesScreen(movieTapAction: { _ in }) as? UIHostingController<TopRatedView>
        
        XCTAssertNotNil(controller)
    }
}
