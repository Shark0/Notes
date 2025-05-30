# 選擇你的架構風格

## 從簡單開始
殺雞焉用牛刀，我覺得若是Domain情境是簡單的CRUD需求，用最直覺的三層架構Controller、Service、Repository處裡就好，就如我在前言放的醜奴兒。

```
少年不識愁滋味，
愛上層樓，愛上層樓。
為賦新詞強說愁。
而今識盡愁滋味，
欲說還休，欲說還休。
卻道天涼好個秋。
```

## 領域的發展
Domain的確有可能變複雜，當一個代碼開始出現switch引導到不同use case時，我就覺得可以開始用Template Design Pattern觀察該use case的相似行為，把相同的寫死，把不同的釋放。但是我不覺得在邏輯變複雜時六角是唯一解。

## 相信自己的經驗
我常看格鬥比賽，對於格鬥術得到的結論是沒有最強的格鬥術只有把格鬥術用最好的選手，我覺得程式開發也是一樣。想讓代碼好維護是一個目標，但是達到這目標並不是一個做法，我喜歡在他人寫的代碼看出Mix Design Pattern，我覺得這才是玩技術的醍醐味，就像我在前言放的笑傲江湖小說片段。

```
那老者搖頭嘆道：「令狐沖你這小子，實在也太不成器！我來教你。
你先使一招『白虹貫日』，跟著便使『有鳳來儀』，再使一招『金雁橫空』，接下來使『截劍式』……」
一口氣滔滔不絕的說了三十招招式。
那三十招招式令狐沖都曾學過，但出劍和腳步方位，卻無論如何連不在一起。
那老者道：「你遲疑甚麼？嗯，三十招一氣呵成，憑你眼下的修為，的確有些不易，你倒先試演一遍看。」
他嗓音低沉，神情蕭索，似是含有無限傷心，但語氣之中自有一股威嚴。
令狐衝心想：「便依言一試，卻也無妨。」當即使一招「白虹貫日」，劍尖朝天，第二招「有鳳來儀」便使不下去，
不由得一呆。那老者道：「唉，蠢才，蠢才！無怪你是岳不群的弟子，拘泥不化，不知變通。
劍術之道，講究如行雲流水，任意所至。你使完那招『白虹貫日』，劍尖向上，難道不會順勢拖下來嗎？
劍招中雖沒這等姿式，難道你不會別出心裁，隨手配合么？」
這一言登時將令狐沖提醒，他長劍一勒，自然而然的便使出「有鳳來儀」，不等劍招變老，已轉「金雁橫空」。
長劍在頭頂划過，一勾一挑，輕輕巧巧的變為「截手式」，轉折之際，天衣無縫，心下甚是舒暢。
當下依著那老者所說，一招一式的使將下去，使到「鐘鼓齊鳴」收劍，堪堪正是三十招，
突然之間，只感到說不出的歡喜。
那老者臉色間卻無嘉許之意，說道：「對是對了，可惜斧鑿痕迹太重，也太笨拙。不過和高手過招固然不成，
對付眼前這小子，只怕也將就成了。上去試試罷！」
```
無物為真，諸行接可