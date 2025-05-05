# TuistCacheMismatch
A repository that showcase a (local) cache mismatch and build issue with Tuist, Datadog and a ProxyRepo

# Prerequisites
### This was tested with the following configuration, although I expect it to reproduce on other Xcode and MacOS versions
- Tuist 4.48.2
- Xcode 16.1
- MacOS 15.4.1

# Steps to reproduce cache issue

1) Clone this repo - `git clone https://github.com/danibachar/TuistCacheMismatch`
2) `cd TuistCacheMismatch`
3) Run `tuist clean` for a clean cached environment
4) Run `tuist install`
5) Run `tuist generate`
6) Make sure the app builds and runs (you might see Datadog logs due to init RUM initialization before SDK init)
7) Close the opened xcode project
8) Run `tuist cache`. This command should cache all the external dependencies of the project (Datadog, and DatadogProxy), locally
9) Run `tuist generate`. The generated app should link against the cached binaries, and not generate projects for the external dependencies (i.e. you should not see the `Dependencies` folder)
10) Make sure the app builds and runs (you might see Datadog logs due to init RUM initialization before SDK init)
11) Run `tuist edit`
12) **Go to `Tuist/Package.swift` and change the Datadog SDK version to `2.26.0`**
13) Run `tuist install`
14) Run `tuist generate`
15) The newly generate project should include the changes, and have no cache hits (i.e. you should see the `Dependencies` folder)
16) Make sure the app builds and runs (you might see Datadog logs due to init RUM initialization before SDK init)
17) Run `tuist cache`
18) Run `tuist generate`
19) Observe build failure with the following error
```sh
Showing All Errors Only
Undefined symbol: DatadogRUM.RUM.Configuration.init(applicationID: Swift.String, sessionSampleRate: Swift.Float, uiKitViewsPredicate: DatadogRUM.UIKitRUMViewsPredicate?, uiKitActionsPredicate: DatadogRUM.UITouchRUMActionsPredicate?, urlSessionTracking: DatadogRUM.RUM.Configuration.URLSessionTracking?, trackFrustrations: Swift.Bool, trackBackgroundEvents: Swift.Bool, longTaskThreshold: Swift.Double?, appHangThreshold: Swift.Double?, trackWatchdogTerminations: Swift.Bool, vitalsUpdateFrequency: DatadogRUM.RUM.Configuration.VitalsFrequency?, viewEventMapper: ((DatadogRUM.RUMViewEvent) -> DatadogRUM.RUMViewEvent)?, resourceEventMapper: ((DatadogRUM.RUMResourceEvent) -> DatadogRUM.RUMResourceEvent?)?, actionEventMapper: ((DatadogRUM.RUMActionEvent) -> DatadogRUM.RUMActionEvent?)?, errorEventMapper: ((DatadogRUM.RUMErrorEvent) -> DatadogRUM.RUMErrorEvent?)?, longTaskEventMapper: ((DatadogRUM.RUMLongTaskEvent) -> DatadogRUM.RUMLongTaskEvent?)?, onSessionStart: ((Swift.String, Swift.Bool) -> ())?, customEndpoint: Foundation.URL?, telemetrySampleRate: Swift.Float) -> DatadogRUM.RUM.Configuration
```

It seems like either Tuist has issue with the hashing of the cached binaries and it mixes cache. Or alternatively, it has a caching issue, and it caches the Proxy library with the wrong version of Datadog SDK. 
