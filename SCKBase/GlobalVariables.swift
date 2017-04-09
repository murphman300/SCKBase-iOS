//
//  GlobalVariables.swift
//  Spotit
//
//  Created by Jean-Louis Murphy on 2017-04-04.
//  Copyright © 2017 Jean-Louis Murphy. All rights reserved.
//

import UIKit


import UIKit

public struct user {
    static let def : UserDefaults = UserDefaults.standard
}

public struct control {
    
    static let checkout: Bool = false
    
    
}

public struct SpotitPaths {
    
    private static let local : String = Connections.node.root
    public struct users {
        private static let root : String = local + "/users"
        public struct login {
            static let facebook : String = root + "/facebooklogin"
        }
        public struct create {
            static let facebookFinal : String = root + "/facebookfinal"
        }
        public struct cell {
            private static let croot : String = root + "/cell"
            static let confirm : String = croot + "/confirm"
            static let auth : String = croot + "/auth"
        }
        public struct wallet {
            private static let croot : String = root + "/wallet"
            static let get : String = croot + "/get"
            public struct methods {
                private static let cmroot : String = local + "/wallet"
                private static let mroot : String = cmroot + "/methods"
                static let update : String = mroot + "/update"
            }
        }
        static let get : String = root
    }
    public struct merchants {
        private static let root : String = local + "/merchant"
        public struct create {
            private static let croot : String = root + "/create"
            static let initial : String = croot + "/initial"
            static let initialUpdate : String = croot + "/initialupdate"
            public struct owner {
                private static let oroot : String = croot + "/owner"
                static let link : String = oroot + "/link"
                static let contact : String = oroot + "/contact"
                static let linkAuth : String = oroot + "/linkauth"
                static let address : String = oroot + "/address"
            }
            static let connect : String = croot + "/connect"
            static let kyc : String = croot + "/upload/kyc"
            static let uploadToken : String = croot + "/wallet/sendtoken"
            static let tosFinal : String = croot + "/tos/final"
        }
        
        public struct check {
            private static let croot : String = root + "/check"
            static let transfers : String = croot + "/transfers"
            
            
        }
        public struct profile {
            private static let croot : String = root + "/profile"
            static let value : String = croot
            
        }
        public struct authenticate {
            private static let croot : String = root + "/authenticate"
            static let value : String = croot
            
        }
        public struct locations {
            private static let croot : String = root + "/locations"
            static let add : String = croot + "/add"
            
            
        }
    }
    public struct location {
        private static let lroot : String = local + "/locations"
        public struct payment {
            private static let croot : String = lroot + "/payment"
            static let request : String = croot + "/resquest"
        }
        public struct process {
            private static let croot : String = lroot + "/process"
            static let request : String = croot + "/payment"
        }
        public struct info {
            private static let croot : String = lroot + "/info"
            static let address : String = croot + "/address"
            static let profile : String = croot + "/profile"
        }
        public struct team {
            private static let croot : String = lroot + "/employees"
            static let managers : String = croot + "/managers"
            static let admins : String = croot + "/admins"
            static let all : String = croot + ""
        }
        public struct devices {
            private static let croot : String = lroot + "/devices"
            static let add : String = croot + "/add"
            static let reasign : String = croot + "/reasign"
        }
    }
}

public struct omnigatePaths {
    
    static let version : String = "v1"
    static let root : String = "https://dev.omnigate.com/"
    static let OAuthURL : String = "https://dev.omnigate.com/auth/authorize?response_type=token&client_id=25434567&redirect_uri=spotit.app:/oauth2redirect"
    static let upProfile : String = "https://dev.omnigate.com/api/v1/profile/update"
    static let profile : String = "https://dev.omnigate.com/api/v1/profile"
    
    static let createProfile : String = "https://dev.omnigate.com/api/v1/profile"
    
    static let getTransports : String = "https://dev.omnigate.com/api/v1/notifications/transports"
    static let getTxList : String = "https://dev.omnigate.com/api/v1/payment/transactionlist"
    static let wallet : String = "https://dev.omnigate.com/api/v1/wallet"
    static let createPaymentRequest : String = "https://dev.omnigate.com/api/v1/payment/request"
    static let acceptPaymentRequest : String = "https://dev.omnigate.com/api/v1/payment/accept"
    
    static let login : String = "https://dev.omnigate.com/api/v1/user/login"
    
    public struct createMerch {
        
        static let toStripe : String = "https://dev.omnigate.com/api/v1/payment/managedaccount"
        static let banklink : String = "https://dev.omnigate.com/api/v1/payment/banklink"
    }
    public struct apiKey {
        
        static let create : String = "https://dev.omnigate.com/api/v1/profile/apikey"
    }
    public struct kyc {
        
        static let upload : String = "https://dev.omnigate.com/api/v1/kyc/uploaddocument"
        static let getkyc : String = "https://dev.omnigate.com/api/v1/profile/kyc/upload"
        static let createTier : String = "https://dev.omnigate.com/api/v1/kyc/tierchangerequest"
        
    }
}

enum httpMet {
    
    case post, get, delete
    
}

enum node {
    
    case profile
    
}

enum omniWallet {
    
    case all, id, balances
    
}

enum actions {
    case update
    
    
}

public struct payment {
    
    static let types : Array<String> = ["amex", "mastercard", "visa", "interac", "debit"]
    enum type {
        case visa, mastercard, amex, debit, interac
    }
}


public struct strings {
    static let fromPerson: String = "is asking you to pay"
    static let fromCheckout: String = "This bill is from"
    static let sendToPeer: String = "Please confirm the details of this transfer"
    static let sendToCheckout: String = "Please confirm the details of this payment"
    static let actPeer: String = "send"
    static let actCheckout: String = "pay"
    static let peerPayee: String = "Send to:"
    static let checkoutPayee: String = "Merchant:"
    static let tIDSending: String = "Sending"
    static let didSeedStore : String = "didSeedPersistentStore"
}

public struct estrings {
    
    static let userTokError : String = "USER DEFAULT ERROR: No string associated with key:"
    
}

public struct screen {
    static let height: CGFloat = (UIApplication.shared.keyWindow?.frame.height)!
    static let width: CGFloat = (UIApplication.shared.keyWindow?.frame.width)!
}

public struct cells {
    
    static let window = UIApplication.shared.keyWindow
    static let methodCell: CGFloat = CGFloat(70/667) * screen.height
    static let tipCell: CGFloat = screen.height * 0.25
    static let chatcellBorder : CGFloat = 0.5
    static let chatCellColor : UIColor = UIColor.white
    
}

public struct colors {
    static let darkenedTransparentBackground : UIColor = UIColor.init(white: 0.5, alpha: 0.5)
    static let lessBlueMainColor : UIColor = UIColor.rgb(red: 10, green: 120, blue: 190)
    static let lightBlueMainColor : UIColor = UIColor.rgb(red: 17, green: 142, blue: 203)
    static let skyBlueMainColor : UIColor = UIColor.rgb(red: 102, green: 204, blue: 255)
    
    static let lineColor : UIColor = UIColor.rgb(red: 60, green: 63, blue: 75)//UIColor.rgb(red: 39, green: 41, blue: 49)
    static let turquoiseColor : UIColor = UIColor.rgb(red: 22, green: 149, blue: 203)
    static let limeColor : UIColor = UIColor.rgb(red: 0, green: 255, blue: 128)
    static let orchidColor : UIColor = UIColor.rgb(red: 102, green: 102, blue: 255)
    static let springGreen : UIColor = UIColor.rgb(red: 0, green: 255, blue: 0)
    
    static let purplishColor : UIColor = UIColor.rgb(red: 63, green: 79, blue: 186)
    static let darkPurplishColor : UIColor = UIColor.rgb(red: 64, green: 0, blue: 128)
    static let highlightedPurplishColor: UIColor = UIColor.rgb(red: 43, green: 59, blue: 136)
    
    static let warningOrange: UIColor = UIColor.rgb(red: 255, green: 128, blue: 0)
    
    static let clearViu = UIColor.init(white: 0.5, alpha: 0.15)
    static let blueishLightBorder: UIColor = UIColor.rgb(red: 122, green: 143, blue: 143)
    static let greenColor: UIColor = UIColor.rgb(red: 22, green: 137, blue: 48)
    static let backcolorfortest : UIColor = UIColor.rgb(red: 247, green: 252, blue: 249)//UIColor.rgb(red: 255, green: 249, blue: 236)
    static let standardBorder: UIColor = UIColor.rgb(red: 58, green: 69, blue: 69)
    
    //TabBar
    static let mainButtonColor: UIColor = lineColor//greenColor//UIColor.rgb(red: 22, green: 219, blue: 48)
    static let mainButtonBorderColor : UIColor = lineColor
    static let tabBarTintColor : UIColor = UIColor.rgb(red: 246, green: 246, blue: 246)
    static let tabBarItemSelected : UIColor = lightBlueMainColor
    
    
    //navBar
    static let navBarTintColor : UIColor = tabBarTintColor//lightBlueMainColor//backcolorfortest //UIColor.rgb(red: 246, green: 246, blue: 235)//tabBarTintColor
    static let navBarTitleColor : UIColor = lightBlueMainColor//lightBlueMainColor//lineColor
    static let navBarBorderColor : UIColor = lineColor//lineColor
    static let methodsBack = UIColor.rgb(red: 193, green: 193, blue: 200)
    static let navBarButtonColor : UIColor = purplishColor
    
    //SideList
    static let sideMenuHigh: UIColor = UIColor.rgb(red: 58, green: 69, blue: 69)
    static let shadowColor1: CGColor = UIColor.black.withAlphaComponent(0.4).cgColor
    static let shadowColor2: CGColor = UIColor.clear.cgColor
    static let methodCell: CGColor = UIColor.rgb(red: 58, green: 69, blue: 69).cgColor
    static let tipBack : UIColor = UIColor.rgb(red: 235, green: 235, blue: 241)
    static let greenSlider: Int = 137
    static let blockButtonColor: UIColor = UIColor.rgb(red: 105, green: 18, blue: 0)
    static let locSearchBarTintColor : UIColor = UIColor.rgb(red: 236, green: 235, blue: 234)
    static let chatTextInputBox : UIColor = UIColor.rgb(red: 252, green: 250, blue: 250)
    static let sideMenuCellTextColor : UIColor = backcolorfortest
    
    //ProfileTab
    static let profileViewButtonColor : UIColor = purplishColor
    //EditProfile
    static let editProfileContainerColor: UIColor = UIColor.rgb(red: 165, green: 221, blue: 250)
    static let toneForEditProfileContainer : UIColor = UIColor.rgb(red: 235, green: 240, blue: 244)
    
    //Login
    static let loginTfBack: UIColor = UIColor.white
    static let loginContainer: UIColor = UIColor.white.withAlphaComponent(0.7)
    
    //signoutcolors
    
    
    static let signoutFromInterface : UIColor = UIColor.rgb(red: 137, green: 0, blue: 100)
    
    public struct accountController {
        
        static let selectorSubviewTab : UIColor = UIColor.rgb(red: 210, green: 214, blue: 224)
        public struct navBar {
            
            static let background : UIColor = colors.loginTfBack
            
        }
    }
    
    static let selector_background : UIColor = colors.lineColor
    static let controller_main_backGround : UIColor = UIColor.rgb(red: 218, green: 224, blue: 234)
}


public struct paymentcards {
    static let visablue: UIColor = UIColor.rgb(red: 20, green: 20, blue: 72)
    static let visalightblue : UIColor = UIColor.rgb(red: 25, green: 25, blue: 77)
}

public struct fonts {
    
    static let navTitle : UIFont = UIFont.systemFont(ofSize: 20)
    
    static let navItem : UIFont = UIFont.systemFont(ofSize: 15)
    
    static let viewTitle : UIFont = UIFont.systemFont(ofSize: 16)
    static let primaryButton : UIFont = UIFont.systemFont(ofSize: 15)
    static let secButton : UIFont = UIFont.systemFont(ofSize: 15)
    
    static let primaryButtonBold : UIFont = UIFont.boldSystemFont(ofSize: 15)
    static let secButtonBold : UIFont = UIFont.boldSystemFont(ofSize: 15)
    
    static let editProfileNameLabel : UIFont = UIFont.boldSystemFont(ofSize: 25)
    static let editProfilePreviewSubLabel : UIFont = UIFont.boldSystemFont(ofSize: 20)//boldSystemFont(ofSize: 20)
    
    static let checkoutMerchBold : UIFont = UIFont.boldSystemFont(ofSize: 18)
    static let checkoutMerch : UIFont = UIFont.systemFont(ofSize: 18)
    
    public struct checkout {
        static let numberPad : UIFont = UIFont.systemFont(ofSize: 25)
        static let boldNumberPad : UIFont = UIFont.boldSystemFont(ofSize: 25)
        
        static let amount : UIFont = UIFont.systemFont(ofSize: 60)
        
    }
    
    public struct createFlow {
        
        static let maintitle: UIFont = UIFont.boldSystemFont(ofSize: 25)
        static let mainsubtitle: UIFont = UIFont.boldSystemFont(ofSize: 20)
        static let subtitle: UIFont = UIFont.boldSystemFont(ofSize: 15)
        
        static let textField: UIFont = UIFont.boldSystemFont(ofSize: 20)
        
        static let bankformsearch: UIFont = UIFont.boldSystemFont(ofSize: 25)
        
        
        
    }
    public struct accountController {
        public struct subviews {
            public struct pushController {
                static let cellTitle : UIFont = UIFont.systemFont(ofSize: 17)
                static let boldCellTitle : UIFont = UIFont.boldSystemFont(ofSize: 17)
                static let sectionTitle : UIFont = UIFont.boldSystemFont(ofSize: 15)
                static let sectionSubTitle : UIFont = UIFont.systemFont(ofSize: 13)
            }
        }
        
        public struct actionViews {
            static let mainTitle : UIFont = UIFont.boldSystemFont(ofSize: 25)
            static let subSectionTitle : UIFont = UIFont.boldSystemFont(ofSize: 18)
            static let subSubSectionTitle : UIFont = UIFont.boldSystemFont(ofSize: 15)
            static let actionable : UIFont = UIFont.boldSystemFont(ofSize: 18)
        }
        
    }
}

public struct checkColors {
    static let signupGreen : UIColor = UIColor.rgb(red: 79, green: 213, blue: 61)
}

public struct keyboard {
    static let alph: String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIKLMNOPQRSTUVWXYZ!@#$%^&*()_-=+}{|:'/<>?()[]"
    static let lowercase : String = "abcdefghijklmnopqrstuvwxyz"
    static let uppercase : String = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    static let guillemet : String = ""
    static let symbols : String = "!@#$%^&*()_+}{|:'/<>?()[],.;-="
    static let digits : String = "1234567890"
    static let all : String = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIKLMNOPQRSTUVWXYZ!@#$%^&*()_-=+}{|:'/<>?()[]"
}

public struct screenLock {
    
    static let val : Bool = true
}

public struct buttonSizes {
    
    
    static let buttonPadding : CGFloat = 16
    static let mainheight: CGFloat = 667 * (0.16 * 0.8 * 0.5)
    
    static let textfcellheight: CGFloat = ((UIScreen.main.bounds.height * 0.3 * 0.75) - 16) * (1/3)
    static let textinputSectionPadding : CGFloat = textfcellheight * 1.5
    static let tfPadding : CGFloat = 8
    
}

public struct DeviceInfo {
    public struct current {
        
        static var model : String {
            get {
                return "iPhone 6S"
            }
        }
        
    }
}

public struct cardSizes {
    
    public struct wallet {
        static var size : CGSize {
            get {
                let h = 375 * 0.4 * 0.9 * 0.1
                return CGSize(width: h * 12, height: h * 8)
            }
        }
    }
    
}



public struct sliderviews {
    public struct pads {
        static let openedWithTab : CGFloat = 48 * 0.8
        static let closedWithTab : CGFloat = 0
    }
    
    public struct cards {
        static let applePayEdit : CGSize = CGSize(width: screen.width * 0.8, height: screen.height * 0.35)
    }
    
    public struct tabBar {
        
    }
}

public struct cellForSetting {
    
    static var size : CGSize = CGSize(width: screen.width, height: 47.25)
    
}

public struct loginSizes {
    public struct signUp {
        static var subScroll : CGSize {
            get {
                let it = CGSize(width: 375, height: 604.31)
                guard screen.width > 325 else {
                    guard screen.height > 465 else {
                        return CGSize(width: 320, height: 460 - 20 - buttonSizes.mainheight)
                    }
                    return CGSize(width: 320, height: it.height)
                }
                guard screen.height > 465 else {
                    guard screen.width > 325 else {
                        return CGSize(width: 320, height: 460 - 20 - buttonSizes.mainheight)
                    }
                    return CGSize(width: it.width, height: 460 - 20 - buttonSizes.mainheight)
                }
                return it
            }
        }
        
        static let nextButton: CGSize = CGSize(width: subScroll.width * 0.9, height: buttonSizes.mainheight)
        static var compLabelPad : CGFloat {
            get {
                return ((16 * 2) + 10)
            }
        }
    }
}

public struct account {
    struct controller {
        static let subviewPadding : CGFloat = screen.height * 0.025
        static let subviewPaddingSide : CGFloat = screen.height * 0.05
        static let selector : CGSize = CGSize(width: 300, height: screen.height)
        static let subview : CGSize = CGSize(width: (screen.width - selector.width) - (subviewPaddingSide * 2), height: screen.height - (buttonSizes.mainheight * 2) - (subviewPadding * 2))
        static let subviewCenterY : CGFloat = (buttonSizes.mainheight * 2) + ((screen.height - (buttonSizes.mainheight * 2)) / 2)
        static let subviewOpenCent : CGFloat = screen.width - (subview.width / 2) - subviewPaddingSide
        
    }
    struct color {
        static let selector_background : UIColor = colors.lineColor
        static let controller_main_backGround : UIColor = UIColor.rgb(red: 218, green: 224, blue: 234)
    }
}

public struct Spotit {
    static let loginSize : CGSize = CGSize(width: 375, height: 667)
}

public struct interfaces {
    
    static var interfaceview : CGSize {
        get {
            let mx = max(UIScreen.main.bounds.width, 1024)
            return CGSize(width: mx, height: 768)
        }
    }
    
    static var interfacescrollsubview : CGSize {
        get {
            return CGSize(width: 1024, height: 573.848)
        }
    }
    
    static var scrollsubcenter : CGFloat {
        get {
            let top : CGFloat = 125
            let H : CGFloat = screen.height / 2
            let h : CGFloat = interfaces.interfacescrollsubview.height / 2
            let inth : CGFloat = interfaces.interfaceview.height / 2
            
            let diff = H - inth
            
            guard diff >= top else {
                
                return h + top - diff
            }
            return inth
        }
    }
    
    //= CGSize(width: 1024, height: 573.848)
}

public struct mapviews {
    public struct legal {
        static let bottomLayoutPadding: CGFloat = 60
    }
}


public struct placeholders {
    
    
    static let cheque : CGSize = CGSize(width: 824, height: 350)
    
}


public struct cornerRadii {
    
    static let checkout: CGFloat = screen.height * 0.1 * 0.5
    
}

public struct mainbuttonconf {
    
    static let window = UIApplication.shared.keyWindow?.frame.width
    
    static let size : CGFloat = window! * (50 / 375)
    
}

public struct notifications {
    
    public struct sso {
        static let tokenAcquiring : String = "GettingTheTokenFromOmni"
    }
    
    public struct data {
        
        static let entreData : String = "EntreCanApplyData"
        
    }
    
    public struct calls {
        static let confirmedAcceptPayment : String = "paymentWasAcceptedAndConfirmedFromBillView"
        static let paymentRecievedAndAcceptedFromCustomer : String = "customerAcceptedAPaymentRequestForGoodsAndServices"
        static let transferRequestRecievedAndAcceptedFromCustomer : String = "peerIndividualAcceptedATransferRequestForAGoodReason"
        static let confirmedCreatePaymentRequest : String = "paymentRequestWasConcievedSuccessfullyFromCreatePaymentView"
    }
    
    public struct notifsHandlers {
        
        
        static let nameForObjectInActorBack : String = "notificationRequestRecievedFromActiveOrBackgroundStateHandleIt"
    }
    
    
}

public struct ids {
    static let uuid : String = "uuid"
    static let upid : String = "upid"
    static let iss : String = "iss"
    static let sub : String = "sub"
    static let waid : String = "waid"
}

public struct merchant {
    static let appleId : String = "merchant.com.Spotit.Spotit"
}
public struct stripe {
    
    static let pubTest : String = "pk_test_kHVxbB2Wp3zfKEAntcACHP2R"//"pk_test_AwHwYfKC8w5vNmEz5D4cnCGV"//pk_test_kHVxbB2Wp3zfKEAntcACHP2R"
    static let publive : String = "pk_live_F9sDblecifMfzItAtoB6ztDW"
}


public struct obsKeys {
    static let remSidePan : String = "sidePanToBeRemovedSinceNavControllerGoingToSecView"
    static let addSidePan : String = "placeSidePanBackSinceNavControllerReturningToTabBar"
    static let profileHasChanged : String = "profileEditorHasChangedUserProfileSoUpdate"
    static let sendProfileHasChanged : String = "tellTabsToUpdateUIsNow"
    //Profile tab activity indicators
    static let walletActivityBegins : String = "WalletHasSomeActivityHappening"
    static let walletActivityEnd : String = "WalletHadSomeActivityHappeningSoEndActivity"
    static let pointsActivityBegins : String = "PointsHasSomeActivityHappening"
    static let pointsActivityEnd : String = "PointsHadSomeActivityHappeningSoEndActivity"
    
    static let checkIndicatorEngage : String = "EngageTheCheckingIndicator"
}

enum ComponentOfDate {
    case day, month, year
}


enum CurveDirection {
    case left, right
}

enum viewSides {
    case left, right, top, bottom
    
}

enum contrastSides {
    case left, right, top, bottom, topRight, topLeft, bottomLeft, bottomRight
}

enum ContrastSides {
    case left, right, top, bottom, topRight, topLeft, bottomLeft, bottomRight
}

enum ContrastSide: String {
    case left = "left"
    case right = "right"
    case bottom = "bottom"
    case top = "top"
    case topLeft = "topLeft"
    case topRight = "topRight"
    case bottomRight = "bottomRight"
    case bottomLeft = "bottomLeft"
    
    init() {
        self = ContrastSide(fromRaw: "left")
    }
    
    init(fromRaw: String) {
        self = ContrastSide(fromRaw: fromRaw)
    }
    
    func toContrast() -> contrastSides {
        guard self.rawValue != "left" else {
            return .left
        }
        guard self.rawValue != "right" else {
            return .right
        }
        guard self.rawValue != "bottom" else {
            return .bottom
        }
        guard self.rawValue != "top" else {
            return .top
        }
        guard self.rawValue != "topLeft" else {
            return .topLeft
        }
        guard self.rawValue != "topRight" else {
            return .topRight
        }
        guard self.rawValue != "bottomRight" else {
            return .bottomRight
        }
        return .bottomLeft
    }
}

enum tokenTypes {
    
    case fb, omni, spotit, device
}

enum userInfos {
    
    case firstName, lastName, sex, age, email, pin, uuid, sub, upid, iss, waid
    
}

enum Encryptable {
    
    case firstName, lastName, sex, age, email, pin, uuid, sub, upid, iss, waid, fb, spotit, device
    
}

enum LoginInfos {
    
    case firstLogin, lastLogin, tokenBirth
    
}

enum LoginStatus {
    
    case isLoggedIn, notLoggedIn
    
}

enum loginType {
    
    case uiweb, wkweb, safarivc
}

enum SafariRoots {
    case viewController, customTabBar, viewControllerSignUp, viewControllerError, download, tabBarNotification
}

enum syncronize {
    case sync, no
}

enum timeLabelType {
    case precise, relative
}

enum methodTypes {
    case legacy, bitcoin, operatingSystem, ripple, giftCards
}

enum ViewCorner {
    
    case topRight, topLeft, bottomRight, bottomLeft
}
