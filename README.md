#ios9-splitscreen-sample

This sample project demonstrates how to conform the split screen feature (introduced in iOS 9) by using UIKit Size Class.
The simplest scenario to adapt Size Class is to share the same view controller for any size classes (like Regular or Compact),
but sometimes this approach may be difficult. One such case is when you want to use UICollectionView for Horizontally-Regular sized view
and UITableView for Horizontally-Compact sized view. In this case you may want to split a view controller for different Size Classes.
This sample project shows you how to swap view controllers for different Size Classes dynamically.

This project is licensed under the MIT license. This project requires Xcode 7.0 (Swift version 2.0) or later to build.

## Usage

Just simply `git clone` and run.

## Expository

### How events are fired when Size Class is changed

https://gist.github.com/akisute/291170b50ad87ce95a47

Here's a log when Size Class is changed on several situations. You can see a couple of interesting behavior from this log:

- `willTransitionToTraitCollection` is only fired when actual Size Class is changed. for example, if you rotate iPhone from landscape right to landscape left (causes 180 degree rotation), this method will not be called.
- `viewWillTransitionToSize` is always fired when the size of the view is updated, even if Size Class itself is actually not changed.

So I think adapting to `willTransitionToTraitCollection` can be useful when you want to update the interface on Size Class update, while `viewWillTransitionToSize` is the best to update your UI dynamically when device is rotating.

### RootViewController.swift

This is the key view controller to implement multiple view controllers for each different Size Classes. This view controller works as a container view controller,
swapping its child view controller depending on the current Size Class. See its code for more details.

### MainViewController_iPhone.swift

This is the view controller for Horizontally-Compact sized view like splitted iPad apps or any portrait iPhone apps. The UITableViewController is the main view of this
view controller. To animate any Size Class changes, you need to call `tableView.beginUpdates()` and `tableView.endUpdates()` followed by `tableView.reloadSections()`
instead of `tableView.reloadData()`.

### MainViewController_iPad.swift

This is the view controller for Horizontally-Regular sized view like iPad or horizontall iPhone 6 plus. The UICollectionView of this view controller dynamically adjusts
its flow layout depending on the current view size (portrait or landscape). To animate any Size Class changes in UICollectionView, just simply call `reloadData()`.
