//
//  iOSSwiftUIViewControllerFactory.swift
//  TMDBDemo
//
//  Created by nikolamilic on 10/6/23.
//

import UIKit
import SwiftUI
import Combine

class iOSSwiftUIViewControllerFactory: ViewControllerFactory {
    func topRatedMoviesScreen(movieTapAction: @escaping (Movie) -> Void) -> UIViewController {
        return UIHostingController(rootView: Text("Top Rated Screen"))
    }
}
