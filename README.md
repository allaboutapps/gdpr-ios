# Policy Manager Library


To support GDPR requirements this library helps manage settings for different tracking services and supports multiple flows to manage when a user agrees to the terms of service and/or the privacy policy.
The Views were written using SwiftUI but they can easily be integrated in projects that use UIKit using `UIHostingController`.


## Usage

An example app is included demonstrating the library's functionality.

### Getting Started

In your App's `AppDelegate`, create an instance of `GDPRManager` and set the third party services giving each service a unique identifier.
Using the instance of `GDPRManager` you have created, show confirmation forms and settings views anywhere in your app.

### Delegate

The framework offers a `GDPRDelegate` protocol to track when Terms of Services are confirmed, data deletion is called, and the user opts in or our of serivces

### Appearance Customization

The framework offers an `Appearance` class to change the primary color and fonts in the confirmation and settings views.

## Version Compatibility

Current Swift compatibility breakdown:

| Swift Version | Framework Version |
| ------------- | ----------------- |
| 5.x           | 1.x               |


## Installation

### Swift Package Manager (Recommended)

<!-- todo -->

### Manually

Just drag and drop the `.swift` files in the `grpr-ios` folder into your project.

