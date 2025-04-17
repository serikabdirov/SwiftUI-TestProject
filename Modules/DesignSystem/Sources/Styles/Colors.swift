import Core
import UIKit

public extension UIColor {
    enum Main {
        /// #FFFFFF
        public static let white = UIColor(hex: "#FFFFFF")
        /// #191919
        public static let black = UIColor(hex: "#191919")
        /// #2F5337
        public static let green1 = UIColor(hex: "#2F5337")
        /// #03D572
        public static let green2 = UIColor(hex: "#03D572")
        /// #B40101
        public static let red1 = UIColor(hex: "#B40101")
        /// #F85B54
        public static let red2 = UIColor(hex: "#F85B54")
    }

    enum Grey {
        /// #262626
        public static let _10 = UIColor(hex: "#262626")
        /// #3D3D3D
        public static let _20 = UIColor(hex: "#3D3D3D")
        /// #545454
        public static let _30 = UIColor(hex: "#545454")
        /// #6B6B6B
        public static let _40 = UIColor(hex: "#6B6B6B")
        /// #828282
        public static let _50 = UIColor(hex: "#828282")
        /// #9A9A9A
        public static let _60 = UIColor(hex: "#9A9A9A")
        /// #B1B1B1
        public static let _70 = UIColor(hex: "#B1B1B1")
        /// #B1B1B1
        public static let _80 = UIColor(hex: "#B1B1B1")
        /// #D0D0D0
        public static let _90 = UIColor(hex: "#D0D0D0")
        /// #EBEBEB
        public static let _92 = UIColor(hex: "#EBEBEB")
        /// #F0F0F0
        public static let _95 = UIColor(hex: "#F0F0F0")
        /// #F6F6F6
        public static let _99 = UIColor(hex: "#F6F6F6")
    }

    enum Green {
        /// #2F5337
        public static let _10 = UIColor(hex: "#2F5337")
        /// #31613E
        public static let _20 = UIColor(hex: "#31613E")
        /// #327044
        public static let _30 = UIColor(hex: "#327044")
        /// #307E4A
        public static let _40 = UIColor(hex: "#307E4A")
        /// #2D8D4F
        public static let _50 = UIColor(hex: "#2D8D4F")
        /// #289B55
        public static let _60 = UIColor(hex: "#289B55")
        /// #22AA5C
        public static let _70 = UIColor(hex: "#22AA5C")
        /// #19B862
        public static let _80 = UIColor(hex: "#19B862")
        /// #0FC76A
        public static let _90 = UIColor(hex: "#0FC76A")
        /// #03D572
        public static let _92 = UIColor(hex: "#03D572")
        /// #03D572
        public static let _99 = UIColor(hex: "#03D572")
        /// #C6FBDE
        public static let _102 = UIColor(hex: "#C6FBDE")
        /// #F0FDF2
        public static let _105 = UIColor(hex: "#F0FDF2")
        /// #F1FBF6
        public static let _110 = UIColor(hex: "#F1FBF6")
        /// #249B23
        public static let gradient = UIColor(hex: "#71BE70")
    }

    enum Additional {
        /// #6770CA
        public static let purple2 = UIColor(hex: "#6770CA")
        /// #F0F9FD
        public static let lightBlue = UIColor(hex: "#F0F9FD")
        /// #F8F8FF
        public static let lightPurple = UIColor(hex: "#F8F8FF")
        /// #E9E9FF
        public static let lightPurple2 = UIColor(hex: "#E9E9FF")
        /// #FFF7F0
        public static let lightOrange = UIColor(hex: "#FFF7F0")
        /// #FFEFE1
        public static let lightOrange2 = UIColor(hex: "#FFEFE1")
        /// #FFE9CD
        public static let lightOrange3 = UIColor(hex: "#FFE9CD")
        /// #FF800B
        public static let orange1 = UIColor(hex: "#FF800B")
        /// #8590FF
        public static let purple = UIColor(hex: "#8590FF")
        /// #F89854
        public static let orange2 = UIColor(hex: "#F89854")
        /// #53798A
        public static let blue1 = UIColor(hex: "#53798A")
        /// #AE6B15
        public static let orange3 = UIColor(hex: "#AE6B15")
        /// #FF6D6D
        public static let pressedLight = UIColor(hex: "#FF6D6D")
        /// #FED8D6
        public static let lightRed = UIColor(hex: "#FED8D6")
        /// #DFFC25B
        public static let bronze = UIColor(hex: "#DFFC25B")
    }

    enum Text {
        /// #191919
        public static let main = UIColor.Main.black
        /// #6B6B6B
        public static let secondary = UIColor.Grey._40
        /// #828282
        public static let tertiary = UIColor.Grey._50
        /// #B1B1B1
        public static let disabled = UIColor.Grey._70
        /// #FFFFFF
        public static let white = UIColor.Main.white
        /// #22AA5C
        public static let url = UIColor.Green._70
    }

    enum Icons {
        /// #191919
        public static let `default` = UIColor.Main.black
        /// #FFFFFF
        public static let white = UIColor.Main.white
        /// #B1B1B1
        public static let disabled = UIColor.Grey._80
        /// #0FC76A
        public static let green = UIColor.Green._90
    }

    enum Background {
        /// #FFFFFF
        public static let white = UIColor.Main.white
        /// #F6F6F6
        public static let grey = UIColor.Grey._99
        /// #F0F0F0
        public static let grey2 = UIColor.Grey._95
        /// #F0FDF2
        public static let greenCard2 = UIColor.Green._105
        /// #F1FBF6
        public static let greenCalendar = UIColor.Green._110
        /// #F0FDF2
        public static let greenCalendarTap = UIColor.Green._105
        /// #FFF7F0
        public static let orangeCalendar = UIColor.Additional.lightOrange
        /// #FFEFE1
        public static let orangeCalendarTap = UIColor.Additional.lightOrange2
        /// #F8F8FF
        public static let purpleCalendar = UIColor.Additional.lightPurple
        /// #E9E9FF
        public static let purpleCalendarTap = UIColor.Additional.lightPurple2
        /// #404040 with alpha: 0.4
        public static let darkChip = UIColor(hex: "#404040").withAlphaComponent(0.4)
        /// #FFFFFF with alpha: 0.4
        public static let whiteChip = UIColor(hex: "FFFFFF").withAlphaComponent(0.4)
        /// #5EE48B
        public static let activityProgressBar = UIColor(hex: "#5EE48B")
        /// #FFF9EB
        public static let yellowActivityCard = UIColor(hex: "#FFF9EB")
    }

    enum Stroke {
        /// #F6F6F6
        public static let lightGrey = UIColor.Grey._99
        /// #0FC76A
        public static let activeGreen = UIColor.Green._90
        /// #545454
        public static let filled = UIColor.Grey._30
        /// #B1B1B1
        public static let `default` = UIColor.Grey._70
    }

    enum TabBar {
        /// #B1B1B1
        public static let `default` = UIColor.Grey._80
        /// #31613E
        public static let tap = UIColor.Green._20
        /// #03D572
        public static let selected = UIColor.Green._99
    }

    enum Error {
        /// #B40101
        public static let text = UIColor.Main.red1
        /// #B40101
        public static let stroke = UIColor.Main.red1
    }

    enum Button {
        /// #0FC76A
        public static let btnPrimary = UIColor.Green._90
        /// #19B862
        public static let btnPrimaryTap = UIColor.Green._80
        /// #B1B1B1
        public static let btnDisabled = UIColor.Grey._70
        /// #262626
        public static let btnSecondary = UIColor.Grey._10
        /// #3D3D3D
        public static let btnSecondaryTap = UIColor.Grey._20
        /// #FFFFFF
        public static let textWhite = UIColor.Text.white
        /// #B1B1B1
        public static let btnTextDisabled = UIColor.Text.disabled
        /// #22AA5C
        public static let textGreen = UIColor.Green._70
        /// #2D8D4F
        public static let textGreenTap = UIColor.Green._50
    }

    enum Timer {
        /// #F0F0F0"
        public static let empty = UIColor.Grey._95
        /// #F85B54
        public static let filled = UIColor.Main.red2
    }

    enum Controls {
        /// #545454
        public static let greyDefault = UIColor.Grey._30
        /// #FFFFFF
        public static let activeDone = UIColor.Main.white
        /// #0FC76A
        public static let activeBackground = UIColor.Green._90
        /// #F0F0F0
        public static let disabled = UIColor.Grey._95
        /// #D0D0D0
        public static let disabledBackground = UIColor.Grey._90
    }
    
    enum Content {
        // #666666
        public static let medium = UIColor(hex: "#666666")
        // #191919
        public static let `default` = UIColor(hex: "#191919")
    }
    
    enum Statistic {
        /// #19B862
        public static let green = UIColor.Green._80
        /// #F85B54
        public static let red = UIColor.Main.red2
        /// #F0F0F0
        public static let bgGrey = UIColor.Grey._95
        /// #F89854
        public static let orange = UIColor.Additional.orange2
    }
    
    enum Subscribe {
        /// #F85B54
        public static let titleRed = UIColor.Main.red2
        /// #FFFFFF
        public static let titleWhite = UIColor.Main.white
    }
}
