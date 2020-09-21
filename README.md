#  Fullscreen UITextView

## Problem

A full screen editable [UITextView](https://developer.apple.com/documentation/uikit/uitextview) is not usable out of the box. If added directly to a View Controller, then the keyboard will cover the Text View after a few lines.

Follow the pattern in this sample project to build a dynamic Text View that is not hidden by a keyboard.

![](textviewscroll.png)

## Solution

The interesting code is in the file textviewscroll/ViewController.swift. The main parts of the solution are-

* The `UITextView` is initialized and layout is done in code
* Constraints for top, leading, trailing are setup once. Bottom constraint is dynamic based on keyboard position
* Notification observers for keyboard events are added on `viewDidLoad` and removed during `deinit`
* In the notification callback `keyboardWillChange` the height of the keyboard is calculated
* Based on the keyboard height, the Bottom constraint is toggled with animation

## Usage

* [Bardun App](https://www.bardunapp.com/) uses this pattern. Bardun is an app for a modern Contacts app with support for Notes and more.

Create a PR to add your usage in an app, or watch/start/fork the repo.
