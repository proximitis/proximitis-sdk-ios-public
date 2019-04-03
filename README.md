# Proximitis SDK iOS Framework

## Instalace SDK 

1. Nainstalujte si databázové řešení Realm - https://realm.io
2. Stáhněte Proximitis SDK z githubu
3. Přetáhněte `ProximitisFramework.framework` do vašeho projektu a přidejte ho do `Embedded Binaries`

## Start SDK 

1. Zkopírujte následující kód do AppDelegate vaší aplikace:

    ```
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
				//Spustí službu Proximitis
				// Doplňte vlastní App Key
        Proximitis.start(with: “your_appkey”)

				//Odkomentujte pro zapnutí debug logování
        // Proximitis.setDebugging(true)
        
				//Nastaví AppDelegate jako delegáta notifikací
        UNUserNotificationCenter.current().delegate = self

        return true
    }
```


2. Přidejte tato volání do AppDelegatu:

   `func applicationDidEnterBackground(_ application: UIApplication) {

        Proximitis.applicationDidEnterBackground()
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
        Proximitis.applicationDidBecomeActive()
    }`


3. Přidejte do AppDelegatu extension pro zpracování notifikací:

`import UserNotifications`

`extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        //Na tomto místě můžete zareagovat pokud uživatel tapne na notifikaci.
        // Poté podstupne zpracování notifikace do služby Proximitis        

        ProximitisNotificationClient.notificationTapped(response: response)
        
        completionHandler()
    }`


4. Vložte následují kód do AppDelegatu:

`extension AppDelegate {
   
    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
				
				//Zpracuje aktualizace na pozadí
        Proximitis.performBackgroundFetch {
            completionHandler(.newData)
        }
    }
}`


5. V nastavení Targetu jděte do záložky `Capabilities -> Background Modes` a zapněte tyto módy.

    - Location updates,
    - Background fetch, 
    - Remote notifications


6. Do Info.plist zkopírujte následující kód a upravte vlastní popisky pro používání polohy

`<key>NSAppTransportSecurity</key>
<dict>
	<key>NSAllowsArbitraryLoads</key>
	<true/>
</dict>

<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
<string>your_location_usage_descriptiton</string>

<key>NSLocationWhenInUseUsageDescription</key>
<string>your_location_usage_descriptiton</string>

<key>NSBluetoothPeripheralUsageDescription</key>
<string>your_ranging_beacons_descriptiton</string>`


## Třídy

### ProximitisListViewController
Vykresluje seznam kampaní.

### ProximitisPageViewController
Vykresluje detail kampaně typu `PAGE`

### ProximitisWebViewController
Vykresluje detail kampaně typu `WEB_VIEW`



## Vizuál

Nastavení vlastního vzhledu základních prvků můžete provést pomocí třídy `ProximitisAppearance`.
Proximitis přebírá nastavení vzhledu z API. Vzhled lze také měnit přímo v aplikaci pomoců následujících parametrů.

Například: 
`let primaryColor = UIColor.red
ProximitisAppearance.setPrimaryColor(primaryColor)`

Volitelné parametry:

`primaryColor`
`backgroundColor`
`titleColor`
`headingColor`
`textColor`
`buttonTextColor`
`buttonColor`
`spacing`
`titleFontSize`
`headingFontSize`
`textFontSize`
`lineHeight`


### Detail kampaně typ PAGE

Jednotlivé vizuální bloky při vykreslování detailu kampaně typu `PAGE` lze přepsat.
Metody vždy přebírají parametr `block` a pozici `y` a vracejí výšku výsledného bloku. 

Jednotlivé bloky jsou:

`drawTitle(block: Block, y: Double) -> Double`
`drawHeading(block: Block, y: Double) -> Double`
`drawText(block: Block, y: Double) -> Double`
`drawImage(block: Block, y: Double) -> Double`
`drawOrderedList(block: Block, y: Double) -> Double`
`drawUnorderedList(block: Block, y: Double) -> Double`
`drawButton(block: Block, y: Double) -> Double`


### Status bar

Nastavení stylu status baru pro View Controllery používané službou Proximitis můžete provést nastavením:
`ProximitisAppearance.setStatusBarStyle(.light)`
