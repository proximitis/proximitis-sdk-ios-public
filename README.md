# iOS - Swift

## Instalace SDK 

Stáhněte Proximitis SDK z Bitbucket repozitáře. Přetáhněte `ProximitisFramework.framework` do vašeho projektu a přidejte ho do `Embedded Binaries`

## Start SDK 

1. Zkopírujte následující kód do AppDelegate vaší aplikace:

```
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    //Spustí službu Proximitis
    // Doplňte vlastní App Key
    Proximitis.shared.start(with: “your_appkey”)

    //Odkomentujte pro zapnutí debug logování
    // Proximitis.setDebugging(true)
    
    //Nastaví AppDelegate jako delegáta notifikací
    UNUserNotificationCenter.current().delegate = self

    return true
}
```


2. Přidejte tato volání do AppDelegatu:

```
func applicationDidEnterBackground(_ application: UIApplication) {
    Proximitis.applicationDidEnterBackground()
}

func applicationDidBecomeActive(_ application: UIApplication) {    
    Proximitis.applicationDidBecomeActive()
}
```


3. Přidejte do AppDelegatu extension pro zpracování notifikací:

```
import UserNotifications

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        // Na tomto místě můžete zareagovat pokud uživatel tapne na notifikaci.
        // Poté podstupne zpracování notifikace do služby Proximitis        

        ProximitisNotificationClient.notificationTapped(response: response)
        
        completionHandler()
    }
}
```


4. Vložte následují kód do AppDelegatu:

```
extension AppDelegate {
   
    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
				
        //Zpracuje aktualizace na pozadí
        Proximitis.shared.performBackgroundFetch {
            completionHandler(.newData)
        }
    }
}
```


5. V nastavení Targetu jděte do záložky `Capabilities -> Background Modes` a zapněte tyto módy:

- Background fetch 
- Uses Bluetooth LE accessories


6. Do Info.plist zkopírujte následující kód a upravte vlastní popisky pro používání polohy

```
<key>NSAppTransportSecurity</key>
<dict>
	<key>NSAllowsArbitraryLoads</key>
	<true/>
</dict>

<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
<string>your_location_usage_descriptiton</string>

<key>NSLocationWhenInUseUsageDescription</key>
<string>your_location_usage_descriptiton</string>

<key>NSBluetoothPeripheralUsageDescription</key>
<string>your_ranging_beacons_descriptiton</string>
```

## Třídy

- `ProximitisListViewController` - vykresluje seznam kampaní

- `ProximitisPageViewController` - vykresluje detail kampaně typu `PAGE`

- `ProximitisWebViewController` - vykresluje detail kampaně typu `WEB_VIEW`

## Vizuál

Nastavení vlastního vzhledu základních prvků můžete provést pomocí třídy `ProximitisAppearance`.
Proximitis přebírá nastavení vzhledu z API. Vzhled lze také měnit přímo v aplikaci pomoců následujících parametrů.

Například: 

```
let primaryColor = UIColor.red
ProximitisAppearance.setPrimaryColor(primaryColor)
```

Volitelné parametry:

- `primaryColor`
- `backgroundColor`
- `titleColor`
- `headingColor`
- `textColor`
- `buttonTextColor`
- `buttonColor`
- `spacing`
- `titleFontSize`
- `headingFontSize`
- `textFontSize`
- `lineHeight`

### Seznam kampaní

Seznam kampaní zobrazuje třída `ProximitisListViewController`. Pokud potřebujete přístup k datům, můžete využít proměnou `campaigns`, která obsahuje všechny relevantní kampaně.


### Detail kampaně typ PAGE

Data pro detail kampaní jsou řazena do jednotlivých, na sebe navazujícíh bloků. K těm můžeme přistupovat pomocí proměné `blocks: Array<DetailBlock>`.
Pokud nechete využít automatické vykreslování detailu kampaně, můžete takto přistupovat k jednotlivých blokům, případně přepsat metody, které vykreslují jednotlivé bloky v  `ProximitisDetail` protocolu.

`- func viewForTitle(block: DetailBlock) -> UIView`
`- func viewForHeading(block: DetailBlock) -> UIView`
`- func viewForParagraph(block: DetailBlock) -> UIView`
`- func viewForImage(block: DetailBlock) -> UIView`
`- func viewForOrderedList(block: DetailBlock) -> UIView`
`- func viewForUnorderedList(block: DetailBlock) -> UIView`
`- func viewForButton(block: DetailBlock) -> UIView`
`- func viewForCustom(block: DetailBlock) -> UIView`


V případě, že data obsahují kromě obvyklých typů bloků i vlastní, volitelný blok, lze tento blok vykreslit pomocí metody `viewForCustom(block: DetailBlock) -> UIView`.


### DetailBlock

`DetailBlock` se skládá z  typu `DetailBlockType` a jednotlivých parametrů uložených v `parameters: Dictionary<String, Any>`. 


### Status bar

Nastavení stylu status baru pro View Controllery používané službou Proximitis můžete provést nastavením `ProximitisAppearance.setStatusBarStyle(.light)`


### Vlastní View pro zobrazení prázdného seznamu, nebo chyby uživateli

Třídy `ProximitisListViewController`,  `ProximitisPageViewController` a `ProximitisWebViewController` mohou uživately graficky zobrazovat upozoznění pokud nastane chyba, nebo je prázdný seznam kampaní. Info obrazovka se uživateli zobrazí automaticky, Lze si však vytvořit vlastní ztvárnění, které ProximitisFramework zobrazí na pozadí ViewControlleru.

`   override var infoScreen: UIView? {
                get {
                    return super.infoScreen
                }
                set {
                    super.infoScreen = self.emptyScreen
                }
        }

    var emptyScreen: UIView {

            let infoView = UIView()

            //.....

            return infoView
     }
`



