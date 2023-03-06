# degpeg-video-call-ios-sdk

[![CI Status](https://img.shields.io/travis/vignesh.mot@gmail.com/degpeg-video-call-ios-sdk.svg?style=flat)](https://travis-ci.org/vignesh.mot@gmail.com/degpeg-video-call-ios-sdk)
[![Version](https://img.shields.io/cocoapods/v/degpeg-video-call-ios-sdk.svg?style=flat)](https://cocoapods.org/pods/degpeg-video-call-ios-sdk)
[![License](https://img.shields.io/cocoapods/l/degpeg-video-call-ios-sdk.svg?style=flat)](https://cocoapods.org/pods/degpeg-video-call-ios-sdk)
[![Platform](https://img.shields.io/cocoapods/p/degpeg-video-call-ios-sdk.svg?style=flat)](https://cocoapods.org/pods/degpeg-video-call-ios-sdk)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
1. Install the following:
        -Xcode 13.3.1 or later
        -Minimum deployment version 13.0
2. Make sure that your project meets these requirements:
Your project must target these platform versions or later: iOS 13
3. Set up a physical Apple device or use a simulator to run your app.

## Installation

Use cocoapods to install this custom control in your project.
1. Create a Podfile if you don't already have one. From the root of your project directory, run the following command:

```
pod init
```
2. To your Podfile, add the degpeg-video-call-ios-sdk pods that you want to use in your app.
```
pod 'degpeg-video-call-ios-sdk'
```
3. Install pods using following command
```
pod install   or pod install --repo-update
```
## Usage
degpeg-video-call-ios-sdk is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'degpeg-video-call-ios-sdk'
```
## Integration of degpeg-video-call-ios-sdk in Your project

1. Add Camera & microphone usage in info.plist

2. Import SDK in your swift file
```
import degpeg_video_call_ios_sdk
```
3. Required host, appID, secretKey to initiate the view.

4. Use DegpegViewManager.getVideoCallView to get the videocall view controller object.
Check below code snippet 
```
        // 1. app id
        // 2. content publisher Id / content prover id
        // 3. app secret
        // 
        // let vc = DegpegViewManager.getVideoCallViewController(
                host: "NjMyODZmNzI2NDA2MGM2OWM4OWNmNzdl",
                appId: "TOeEeWktZ2xaruLg",
                secretKey: "degpegAditya Degpeg_NABKUyKE")
        for present 
            self.present(vc, animated: true)
        for push
            self.navigationController?.pushViewController(vc, animated: true)
        
```

## Author

Vignesh Selvaraj, vignesh.s@degpeg.com

## License

degpeg-video-call-ios-sdk is available under the MIT license. See the LICENSE file for more info.
