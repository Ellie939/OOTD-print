
import SwiftUI

// 定義穿搭資料型別
// 建立一個叫做 Outfit 的資料型別，這個資料型別會有name...等等的文字屬性（可以想像成column名稱）
struct Outfit {
    let name: String             // 穿搭名稱
    let outfitImageName: String  // 穿搭圖片
    let colorImageName: String   // 配色圖片
    let items: String            // 穿搭單品
    let description: String      // 穿搭介紹
}


// 主畫面
// 建立Array類似let numbers: [Int] = [1, 2, 3]

struct ContentView: View {

    // 五套穿搭資料
    // 符合作業要求：至少五筆資料，儲存在 Array

    //建立一個叫 outfits 的 Array，裡面每一筆資料都必須是 Outfit
    private let outfits: [Outfit] = [

        // outfits[0]
        Outfit(
            name: "豹紋檸檬黃",
            outfitImageName: "outfit1",
            colorImageName: "colors1",
            items: "奶油黃色澎袖襯衫／黑色短裙褲／豹紋瑪莉珍鞋／黑色墨鏡／金色飾品",
            description: "以柔和的奶油黃搭配俐落黑色，再用豹紋鞋增添復古亮點。甜美與個性之間，剛好取得完美平衡。"
        ),
        
        // outfits[1]
        Outfit(
            name: "薄荷巧克力",
            outfitImageName: "outfit2",
            colorImageName: "colors2",
            items: "薄荷藍拼接針織上衣／巧克力棕寬褲／銀色小包",
            description: "清爽的薄荷藍遇上濃郁巧克力棕，形成溫柔又特別的撞色組合。簡單的兩件式，也能穿出獨特的配色巧思。"
        ),

        // outfits[2]
        Outfit(
            name: "美式丹寧",
            outfitImageName: "outfit3",
            colorImageName: "colors3",
            items: "紅色貝雷帽／深藍丹寧外套／紅色內搭／寬版牛仔褲／紅色球鞋／手提包",
            description: "以 Denim on Denim 打造率性美式風格，透過紅色貝雷帽與球鞋呼應，讓經典牛仔穿搭多了一點俏皮與復古感。"
        ),

        // outfits[3]
        Outfit(
            name: "藍天白雲",
            outfitImageName: "outfit4",
            colorImageName: "colors4",
            items: "奶油白蕾絲洋裝／淺藍色寬版牛仔褲／白色鞋款／編織頭飾",
            description: "輕盈的奶油白蕾絲疊穿水洗藍丹寧，就像藍天與白雲的柔和組合。浪漫又自在，是帶點慵懶感的日常穿搭。"
        ),

        // outfits[4]
        Outfit(
            name: "森系女孩",
            outfitImageName: "outfit5",
            colorImageName: "colors5",
            items: "鼠尾草綠長洋裝／奶油白刺繡針織外套／民族風側背包／綠色帆布鞋／森林系飾品",
            description: "以柔和的鼠尾草綠為主角，搭配花朵刺繡和復古織紋配件。自然、溫暖又帶點童話氣息，像是準備去森林散步的女孩。"
        )
    ]

    // 狀態變數
    // @State 改變時，SwiftUI 會更新畫面

    @State private var selectedOutfitIndex = 0

    // 控制小票是否出現
    @State private var showReceipt = false

    // 控制是否正在列印
    @State private var isPrinting = false

    // 記錄列印次數
    @State private var printCount = 0

    // 顏色設定

    private let backgroundColor = Color.white

    private let darkBrown = Color(
        red: 0.30,
        green: 0.23,
        blue: 0.20
    )

    // 尺寸設定
    //列印寬
    private let printerWidth: CGFloat = 350
    private let printerHeight: CGFloat = 75

    // 小票寬
    private let receiptWidth: CGFloat = 260

    // 小票高度
    private let receiptHeight: CGFloat = 790

    // 白色縫隙約位於列印機高度的中間
    private let receiptStartY: CGFloat = 38
    
    // 主畫面

    var body: some View {

        ZStack {

            backgroundColor
                .ignoresSafeArea()

            ScrollView {

                VStack(spacing: 0) {

                    // 標題

                    VStack(spacing: 8) {

                        Text("THE DAILY OUTFIT MACHINE")
                            .font(.system(size: 11, weight: .medium))
                            .tracking(2.5)
                            .foregroundStyle(darkBrown)

                        Text("今天穿什麼？")
                            .font(.system(size: 34, weight: .bold))
                            .foregroundStyle(darkBrown)

                        Text("Your daily outfit")
                            .font(.system(size: 12))
                            .foregroundStyle(.secondary)

                    }
                    .padding(.top, 35)
                    .padding(.bottom, 30)

                    
                    // 列印機 + 小票

                    ZStack(alignment: .top) {

                        // 第一層：咖啡色列印機背景
                        Image("printerBackground")
                            .resizable()
                            .scaledToFit()
                            .frame(
                                width: printerWidth,
                                height: printerHeight
                            )
                            .zIndex(1)

                        // 第二層：小票
                        // 小票疊在列印機上方，
                        // 頂端對準白色出紙縫的中間

                        ReceiptView(
                            outfit: outfits[selectedOutfitIndex],
                            lookNumber: selectedOutfitIndex + 1,
                            printNumber: printCount,
                            receiptHeight: receiptHeight
                        )
                        .frame(
                            width: receiptWidth,
                            height: receiptHeight,
                            alignment: .top
                        )

                        // 控制小票逐漸露出的長度
                        .frame(
                            height: showReceipt ? receiptHeight : 0,
                            alignment: .top
                        )
                        .clipped()

                        // 從白線中央開始吐出
                        .offset(y: receiptStartY)

                        // 小票蓋在機器圖片上面
                        .zIndex(2)
                    }
                    .frame(
                        height: showReceipt
                            ? receiptHeight + receiptStartY
                            : printerHeight,
                        alignment: .top
                    )
                    .frame(maxWidth: .infinity)


                    // 隨機列印按鈕

                    Button {

                        printOutfit()

                    } label: {

                        HStack(spacing: 12) {

                            Image(systemName: "printer.fill")

                            Text(
                                isPrinting
                                ? "PRINTING..."
                                : "PRINT MY LOOK"
                            )
                            .fontWeight(.bold)
                            .tracking(1.5)

                        }
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 18)
                        .background(darkBrown)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 15)
                        )

                    }
                    .disabled(isPrinting)
                    .opacity(isPrinting ? 0.6 : 1)
                    .padding(.horizontal, 35)
                    .padding(.top, 28)

                    // MARK: 底部文字

                    Text("ONE DAY, ONE OUTFIT ♡")
                        .font(.system(size: 10, weight: .medium))
                        .tracking(2.5)
                        .foregroundStyle(darkBrown.opacity(0.65))
                        .padding(.top, 20)
                        .padding(.bottom, 40)

                }
                .frame(maxWidth: .infinity)
            }
        }
    }

    // 隨機列印功能

    private func printOutfit() {

        // 正在列印時，不接受第二次點擊
        guard !isPrinting else { return }

        isPrinting = true

        // 先收起上一張小票
        // 不使用動畫，讓下一次列印從頭開始

        var transaction = Transaction()
        transaction.disablesAnimations = true

        withTransaction(transaction) {
            showReceipt = false
        }

        // 隨機選擇穿搭

        // 避免連續抽到相同的一套
        // 五套資料中選擇其他四套之一

        let availableIndices = outfits.indices.filter {
            $0 != selectedOutfitIndex
        }

        if printCount == 0 {

            // 第一次列印可以抽到五套中的任何一套
            selectedOutfitIndex = .random(in: outfits.indices)

        } else if let randomIndex = availableIndices.randomElement() {

            // 第二次開始避免連續重複
            selectedOutfitIndex = randomIndex
        }

        // 列印次數 +1
        printCount += 1

        // 吐紙動畫

        // 先讓畫面完成收起舊小票
        DispatchQueue.main.asyncAfter(
            deadline: .now() + 0.15
        ) {

            // 2.3 秒內由上往下展開小票
            withAnimation(.easeOut(duration: 2.3)) {
                showReceipt = true
            }
        }

        // 動畫結束，恢復按鈕
        DispatchQueue.main.asyncAfter(
            deadline: .now() + 2.5
        ) {
            isPrinting = false
        }
    }
}


// 小票 View
// 與課堂的 DiceView 概念相同
// ContentView 將 Outfit 資料傳進來

struct ReceiptView: View {

    let outfit: Outfit
    let lookNumber: Int
    let printNumber: Int
    let receiptHeight: CGFloat

    private let inkColor = Color(
        red: 0.27,
        green: 0.21,
        blue: 0.18
    )

    var body: some View {

        // 小票背景與內容

        ZStack(alignment: .top) {

            // 白色小票背景圖
            // 建議提供直式長方形 PNG
            // 內容與背景會一起移動

            Image("receiptPaper")
                .resizable()
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity
                )

            // 小票內容

            VStack(spacing: 10) {

                // 小票上方標題

                Text("OOTD RECEIPT")
                    .font(
                        .system(
                            size: 18,
                            weight: .black,
                            design: .serif
                        )
                    )
                    .tracking(2)

                Text("YOUR PERSONAL STYLE PICK")
                    .font(
                        .system(
                            size: 9,
                            design: .monospaced
                        )
                    )
                    .tracking(1)

                receiptDivider

                HStack {

                    Text("NO. \(String(format: "%03d", printNumber))")

                    Spacer()

                    Text("LOOK \(String(format: "%02d", lookNumber))")

                }
                .font(
                    .system(
                        size: 10,
                        design: .monospaced
                    )
                )

                // 穿搭名稱

                Text(outfit.name)
                    .font(
                        .system(
                            size: 25,
                            weight: .bold,
                            design: .serif
                        )
                    )
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 5)

                // 穿搭圖片
                // 每一套使用不同的 outfit 圖片

                Image(outfit.outfitImageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 210)
                    .frame(maxWidth: .infinity)

                // 配色圖片

                Text("COLOR PALETTE")
                    .font(
                        .system(
                            size: 10,
                            weight: .bold,
                            design: .monospaced
                        )
                    )
                    .tracking(1.5)

                Image(outfit.colorImageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 42)
                    .frame(maxWidth: .infinity)

                receiptDivider

                // 描述一
                // 穿搭包含哪些單品

                VStack(alignment: .leading, spacing: 6) {

                    Text("OUTFIT DETAILS")
                        .font(
                            .system(
                                size: 10,
                                weight: .bold,
                                design: .monospaced
                            )
                        )
                        .tracking(1)

                    Text(outfit.items)
                        .font(.system(size: 12))
                        .lineSpacing(4)
                        .fixedSize(
                            horizontal: false,
                            vertical: true
                        )

                }
                .frame(
                    maxWidth: .infinity,
                    alignment: .leading
                )

                receiptDivider

                // 描述二
                // 穿搭風格介紹

                VStack(alignment: .leading, spacing: 6) {

                    Text("STYLE NOTES")
                        .font(
                            .system(
                                size: 10,
                                weight: .bold,
                                design: .monospaced
                            )
                        )
                        .tracking(1)

                    Text(outfit.description)
                        .font(.system(size: 12))
                        .lineSpacing(4)
                        .fixedSize(
                            horizontal: false,
                            vertical: true
                        )

                }
                .frame(
                    maxWidth: .infinity,
                    alignment: .leading
                )

                receiptDivider

                // 小票底部

                Text("THANK YOU FOR BEING YOU ♡")
                    .font(
                        .system(
                            size: 10,
                            design: .monospaced
                        )
                    )
                    .multilineTextAlignment(.center)

                // 裝飾性條碼

                HStack(spacing: 2) {

                    ForEach(0..<34, id: \.self) { index in

                        Rectangle()
                            .fill(inkColor)
                            .frame(
                                width: index % 3 == 0 ? 3 : 1,
                                height: 24
                            )
                    }
                }
                .padding(.top, 3)

                Text("DAILY OUTFIT STUDIO")
                    .font(
                        .system(
                            size: 9,
                            design: .monospaced
                        )
                    )
            }
            .foregroundStyle(inkColor)
            .padding(.horizontal, 25)
            .padding(.top, 30)
            .padding(.bottom, 25)
        }
        .frame(height: receiptHeight)
    }

    // 小票虛線分隔

    private var receiptDivider: some View {

        Rectangle()
            .fill(inkColor.opacity(0.25))
            .frame(height: 1)
            .padding(.vertical, 5)
    }
}


#Preview {
    ContentView()
}
