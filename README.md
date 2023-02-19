# Policy Manager Library

[![Swift 5 ](https://img.shields.io/badge/Language-Swift%205-green)](https://developer.apple.com/swift)
[![SPM ](https://img.shields.io/badge/SPM-Compatible-orange)](https://swift.org/package-manager/)

To support GDPR requirements this library helps manage settings for different tracking services and supports multiple flows to manage when a user agrees to the terms of service and the privacy policy.
The Views were written using SwiftUI but they can easily be integrated in projects that use UIKit using `UIHostingController`.


## Usage

An example app is included demonstrating the library's functionality.

### Getting Started

Start with setting up the terms and privacy policy urls of your app, and setting third-party services.
Each service must have a unique id in order to track its changes. 

```swift
let gdprManager = GDPRManager.shared
GDPRManager.shared.setURLs(termsURL: Bundle.main.url(forResource: "terms_of_service", withExtension: "html")!, privacyPolicyURL: Bundle.main.url(forResource: "privacy_policy", withExtension: "html")!)
gdprManager.delegate = self
        
gdprManager.setService(id: "S1", name: "Service Example 1", description: "Description", supportDeletion: true)
gdprManager.setService(id: "S2", name: "Service Example 2", description: "Description", supportDeletion: false)
}
```

### Use Cases

The sdk offers three options:
- Show the settings to the user without forcing them to accept the terms.
- Show the settings as a form and force the user to accept the terms in order to proceed.
- Show an alert telling the user that the terms and conditions have changed.

#### Show Settings
```swift
GDPRManager.shared.showSettings(title: "Legal Settings")
```
#### Show Form
```swift
GDPRManager.shared.showForm(title: "Legal Settings", onConfirm: { [weak self] in
    // proceed to next step
    print("Confirmed!")
}))
```
#### Show Alert
```swift
let alert = GDPRManager.shared.showAlert(title: "Legal Settings") { [weak self] view in
    // this view is the setting view that can be presented if the user chooses the option to read new terms and conditions
}
present(alert, animated: true, completion: nil)
```

### Helper Functions
- Update the latest terms/privacy policy time stamp:
```swift
GDPRManager.shared.updateLatestPolicyTimestamp(date: Date())
```
- Check if user accepted the latest terms:
```swift
GDPRManager.shared.shouldPresentTOS() -> Bool
```
- Accept the latest terms:
```swift
GDPRManager.shared.acceptTermsAndPolicy()
```

### Delegate

The framework offers a `GDPRDelegate` protocol to track when Terms of Services are confirmed, data deletion is called, and the user opts in or our of serivces.
```swift
func serviceValueDidChange(id: String, value: Bool)
func deleteDate(id: String)
func termsAndConditionsAccepted()
```

### Appearance Customization

The framework offers an `Appearance` class to customize colors and fonts.

## Version Compatibility

Current Swift compatibility breakdown:

| Swift Version | Framework Version |
| ------------- | ----------------- |
| 5.x           | 1.x               |


## Installation

### Swift Package Manager (Recommended)

Add the following dependency to your `Package.swift` file:

```
.package(url: "https://github.com/allaboutapps/gdpr-ios", from: "1.2.0")
```

### Manually

Just drag and drop the `.swift` files in the `grpr-ios` folder into your project.

