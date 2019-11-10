//
//  UIPageViewController+goToNextPage.swift
//  Domestika
//
//  Created by Enrique Blasco Blanquer on 10/11/2019.
//  Copyright © 2019 eblasco. All rights reserved.
//

import UIKit

extension UIPageViewController {

    func goToNextPage(){

        guard let currentViewController = self.viewControllers?.first else { return }

        guard let nextViewController = dataSource?.pageViewController( self, viewControllerAfter: currentViewController ) else { return }

        setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)

    }


    func goToPreviousPage(){

        guard let currentViewController = self.viewControllers?.first else { return }

        guard let previousViewController = dataSource?.pageViewController( self, viewControllerBefore: currentViewController ) else { return }

        setViewControllers([previousViewController], direction: .reverse, animated: true, completion: nil)

    }

}
