//
//  CoursesPageViewController.swift
//  Domestika
//
//  Created by Enrique Blasco Blanquer on 10/11/2019.
//  Copyright © 2019 eblasco. All rights reserved.
//

import UIKit

/**
 Carousel of courses
 */
class CoursesPageViewController: UIPageViewController,UIPageViewControllerDataSource,UIGestureRecognizerDelegate{
    var coursesList:[Course]? //list of courses to show
    var listViews:[UIViewController]? = [] //list of subviews inside of the carousel
    var pageControl = UIPageControl(frame: .zero) //Bottom dotteds
    var currentView = 0 //int to determine the current view showing in carousel
    var timerPage:Timer? //timer to start automatic carousel
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate   = self
        self.setViewsForPageViewController()
        self.configPageControl()
        //start animating the carousel
        self.timerPage = Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(CoursesPageViewController.setPageControll), userInfo: nil, repeats: true)
    }
    
    /**
     when user tap in carousel we stop automatic animation
     */
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.view.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: nil)
        tapGesture.delegate = self
        self.view.addGestureRecognizer(tapGesture)
    }
    
    /**
     instance all courses subviews
     */
    private func setViewsForPageViewController(){
        var isFirst = true
        for course in coursesList!{
            let view:PaginatedCoursesViewController = self.storyboard?.instantiateViewController(withIdentifier: "paginatedCourse") as! PaginatedCoursesViewController
            view.course = course
            listViews?.append(view)
            if isFirst {
                setViewControllers([view], direction: .forward, animated: true, completion: nil)
                isFirst = false
            }
        }
    }
    
    /**
     configure the bottom dotteds
     */
    private func configPageControl(){
        pageControl.addTarget(self, action: #selector(self.pageControlSelectionAction(_:)), for: .touchUpInside)
        pageControl.numberOfPages = listViews!.count
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = UIColor.white
        pageControl.pageIndicatorTintColor = UIColor.lightGray.withAlphaComponent(0.8)
        
        let leading = NSLayoutConstraint(item: pageControl, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0)
        let trailing = NSLayoutConstraint(item: pageControl, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)
        let bottom = NSLayoutConstraint(item: pageControl, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        
        self.view.insertSubview(pageControl, at: 0)
        self.view.bringSubviewToFront(pageControl)
        self.view.addConstraints([leading, trailing, bottom])
    }
    
    /**
     function called automatically by the timer. Go to next course
     */
    @objc func setPageControll(){
        changeCourse(page: pageControl.currentPage + 1)
    }
    
    /**
     function called automatically by the page control. Go to next course
     */
    @objc func pageControlSelectionAction(_ sender: UIPageControl) {
        let page: Int? = sender.currentPage
        changeCourse(page: page!)
    }
    
    /**
     change next o prev course. Called by the page control (dotteds)
     */
    private func changeCourse(page:Int){
        pageControl.currentPage = page
        if page >= currentView && page != 0 {
            self.goToNextPage()
        }else{
            self.goToPreviousPage()
        }
    }
    
    
    // MARK: - Page view controller navigation control
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        currentView -= 1
        
        guard let viewControllerIndex = listViews!.firstIndex(of: viewController) else { return nil }
        
        //print dotted
        let previousIndex = viewControllerIndex - 1
        if currentView == -1 {
            pageControl.currentPage = listViews!.count - 1
            currentView  = listViews!.count - 1        }
        else if previousIndex < currentView{
            pageControl.currentPage = currentView
        }else{
            pageControl.currentPage = previousIndex
        }
        
        guard previousIndex >= 0          else { return listViews!.last }
        
        guard listViews!.count > previousIndex else { return nil        }
        
        return listViews![previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        currentView += 1
        
        guard let viewControllerIndex = listViews!.firstIndex(of: viewController) else { return nil }
        
        let nextIndex = viewControllerIndex + 1
        
        //print dotted
        if currentView > (listViews!.count - 1) || currentView == 0 {
            pageControl.currentPage = 0
            currentView = 0
        }else if nextIndex > currentView{
            pageControl.currentPage = currentView
        }else{
            pageControl.currentPage = nextIndex
        }
        
        guard nextIndex < listViews!.count else { return listViews!.first }
        
        guard listViews!.count > nextIndex else { return nil         }
        
        return listViews![nextIndex]
    }
    
    
    /**
     invalidate timer when user tap in carousel
     */
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if timerPage != nil {
            timerPage!.invalidate()
            timerPage = nil
        }
        return false
    }
}



extension CoursesPageViewController: UIPageViewControllerDelegate { }




