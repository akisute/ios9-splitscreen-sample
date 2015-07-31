//
//  ViewController.swift
//  ios9
//
//  Created by Ono Masashi on 2015/06/15.
//  Copyright © 2015年 akisute. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        NSLog("\(__FUNCTION__)")
        super.viewDidLoad()
        self.view.translatesAutoresizingMaskIntoConstraints = false
        self.updateViewControllers(self.traitCollection, size: self.view.bounds.size, coordinatorOrNil: self.transitionCoordinator())
    }
    
    override func viewWillAppear(animated: Bool) {
        NSLog("\(__FUNCTION__) - \(animated)")
    }
    
    override func viewDidAppear(animated: Bool) {
        NSLog("\(__FUNCTION__) - \(animated)")
    }
    
    override func viewWillDisappear(animated: Bool) {
        NSLog("\(__FUNCTION__) - \(animated)")
    }
    
    override func viewDidDisappear(animated: Bool) {
        NSLog("\(__FUNCTION__) - \(animated)")
    }
    
    override func viewWillLayoutSubviews() {
        NSLog("\(__FUNCTION__)")
    }
    
    override func viewDidLayoutSubviews() {
        NSLog("\(__FUNCTION__)")
    }
    
    // MARK: - UITraitEnvironment
    
    override func traitCollectionDidChange(previousTraitCollection: UITraitCollection?) {
        NSLog("\(__FUNCTION__) - \(previousTraitCollection)")
    }
    
    // MARK: - UIContentContainer
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        NSLog("\(__FUNCTION__) - \(size) \(coordinator)")
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        self.updateViewControllers(self.traitCollection, size: size, coordinatorOrNil: coordinator)
    }
    
    override func willTransitionToTraitCollection(newCollection: UITraitCollection, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        NSLog("\(__FUNCTION__) - \(newCollection) \(coordinator)")
        super.willTransitionToTraitCollection(newCollection, withTransitionCoordinator: coordinator)
        self.updateViewControllers(newCollection, size: self.view.bounds.size, coordinatorOrNil: coordinator)
    }
    
    override func sizeForChildContentContainer(container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        NSLog("\(__FUNCTION__) - \(container) \(parentSize)")
        return super.sizeForChildContentContainer(container, withParentContainerSize: parentSize)
    }
    
    override func preferredContentSizeDidChangeForChildContentContainer(container: UIContentContainer) {
        NSLog("\(__FUNCTION__) - \(container)")
        super.preferredContentSizeDidChangeForChildContentContainer(container)
    }

    override func systemLayoutFittingSizeDidChangeForChildContentContainer(container: UIContentContainer) {
        NSLog("\(__FUNCTION__) - \(container)")
        super.systemLayoutFittingSizeDidChangeForChildContentContainer(container)
    }
    
    // MARK: - Deprecated rotation methods
    
    override func willAnimateRotationToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        // This will not be called when new Size Class based methods are implemented
        NSLog("\(__FUNCTION__) - \(toInterfaceOrientation) \(duration)")
    }
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        // This will not be called when new Size Class based methods are implemented
        NSLog("\(__FUNCTION__) - \(fromInterfaceOrientation)")
    }
    
    // MARK: - Private
    
    private func updateViewControllers(traitCollection: UITraitCollection, size: CGSize, coordinatorOrNil: UIViewControllerTransitionCoordinator?) {
        // Strategy
        // 1. If there's no child view controllers, place them according to the given parameters. No animation is required.
        // 2. If trait collection is changed, replace current child view controllers accordingly. No animation is required.
        // 3. Else if size is changed, let child view controllers handle it. Animate if transitionCoordinator is available.
        if self.childViewControllers.count == 0
            || self.traitCollection.horizontalSizeClass != traitCollection.horizontalSizeClass {
                switch traitCollection.horizontalSizeClass {
                case .Unspecified:
                    // unspecified width, won't happen
                    fatalError("Unspecified horizontalSizeClass for traitCollection \(traitCollection)")
                case .Compact:
                    // compact width, iPhone UI
                    let name = "MainViewController_iPhone"
                    guard let viewController = UIStoryboard(name: name, bundle: nil).instantiateInitialViewController() else {
                        fatalError("Failed to instantiate view controller \(name)")
                    }
                    self.transitionToViewcontroller(viewController, coordinatorOrNil: coordinatorOrNil)
                case .Regular:
                    // regular width, iPad UI
                    let name = "MainViewController_iPad"
                    guard let viewController = UIStoryboard(name: name, bundle: nil).instantiateInitialViewController() else {
                        fatalError("Failed to instantiate view controller \(name)")
                    }
                    self.transitionToViewcontroller(viewController, coordinatorOrNil: coordinatorOrNil)
                }
        } else if self.view.bounds.size != size {
            // do nothing, let child view controllers handle this situation
        }
    }
    
    private func updateOutlets() {
        // do nothing
    }
    
    private func transitionToViewcontroller(toViewController: UIViewController, coordinatorOrNil: UIViewControllerTransitionCoordinator?) {
        if let fromViewController = self.childViewControllers.first {
            // transition from-to
            if let coordinator = coordinatorOrNil {
                fromViewController.endAppearanceTransition()
                self.addChildViewController(toViewController)
                toViewController.didMoveToParentViewController(self)
                toViewController.beginAppearanceTransition(true, animated: true)
                fromViewController.beginAppearanceTransition(false, animated: true)
                fromViewController.view.alpha = 1
                toViewController.view.alpha = 0
                self.view.addSubview(toViewController.view)
                self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[view]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view": toViewController.view]))
                self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[view]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view": toViewController.view]))
                coordinator.animateAlongsideTransitionInView(self.view, animation: { context in
                    fromViewController.view.alpha = 0
                    toViewController.view.alpha = 1
                    }, completion: { context in
                        fromViewController.view.removeFromSuperview()
                        toViewController.endAppearanceTransition()
                        fromViewController.willMoveToParentViewController(nil)
                        fromViewController.removeFromParentViewController()
                })
            } else {
                self.addChildViewController(toViewController)
                toViewController.didMoveToParentViewController(self)
                toViewController.beginAppearanceTransition(true, animated: false)
                fromViewController.beginAppearanceTransition(false, animated: false)
                self.view.addSubview(toViewController.view)
                self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[view]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view": toViewController.view]))
                self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[view]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view": toViewController.view]))
                fromViewController.view.removeFromSuperview()
                toViewController.endAppearanceTransition()
                fromViewController.endAppearanceTransition()
                fromViewController.willMoveToParentViewController(nil)
                fromViewController.removeFromParentViewController()
            }
        } else {
            // no transition, just add a new child
            // animation is always disabled
            self.addChildViewController(toViewController)
            toViewController.didMoveToParentViewController(self)
            toViewController.beginAppearanceTransition(true, animated: false)
            self.view.addSubview(toViewController.view)
            self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[view]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view": toViewController.view]))
            self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[view]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view": toViewController.view]))
            toViewController.endAppearanceTransition()
        }
    }
}

