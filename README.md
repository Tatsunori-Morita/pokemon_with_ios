## ポケモンWITH
「ポケモンWITH」は大好きなポケモンともっと一緒にいられるアプリです。  
アプリをインストールして、ウィジェットに追加すれば、あなたの好きなポケモン、  
まだ見たことないポケモンと出会えるかもしれません。  
あなたのそばにもっとポケモンを感じてみませんか？  

アプリの主な特徴を紹介します。
1. ランダムなポケモン表示:  
  「ポケモンWITH」はランダムに選ばれたポケモンをウィジェットに表示します。  
  新しいポケモンに出会い、その特徴や情報を知る楽しさがあります。
2. ポケモンの詳細情報:   
  ウィジェットに表示されたポケモンは、アプリ内のポケモン図鑑で簡単にアクセスできます。  
  ポケモンの名前、タイプ、詳細といった興味深いデータを見ることができます。
3. 設定の変更:  
  外観をダークモード、ライトモードから選択できます。  
  また表示言語を英語、日本語での表示切り替え機能でいつでもお好きな設定に切り替え可能です。  

「ポケモンWITH」は、ポケモンのファンや新たなポケモンの発見を楽しみたい人にとって理想的なアプリです。  
毎日の楽しみとして、「ポケモンWITH」をダウンロードして、ポケモンの世界に没頭しましょう。

## 作成の動機
幅広い世代に人気の「ポケモン」。一度は遊んだ経験があると思います。  
初代ポケモンを遊んだこどもが大人になり、親となり、そのこどもが新しいシリーズの「ポケモン」で遊ぶ。  
親世代には懐かしい「ポケモン」、初めてみる「ポケモン」、ジェネレーションギャップを感じるかもしれません。  
そんなギャップを親子で一緒に楽しみ、コミュニケーションのツールとなるようにとの想いで作成しました。  
ランダムに「ポケモン」が表示されることで、次にどんな「ポケモン」が出現するのか。  
親世代が知らない「ポケモン」について、こどもに教えてもらう。  
逆に親世代も知っている「ポケモン」について、共通の話題として楽しむ、そんな時間を作り出せれば嬉しいです。

## メイン機能
- ウィジェットにポケモンをランダム表示
- ポケモン図鑑の閲覧
- 日本語/英語表記の変更
- ライトモード/ダークモードの変更

## ビルド方法
1.プロジェクトをローカルにダウンロード  
2.実機、またはシミュレーターでビルド・実行  
3.ホーム画面にウィジェットを追加  

## アプリケーション構成

## こだわったポイント
- 設定から言語モードの変更
- 設定からライトモード/ダークモードの変更
- シンプルなデザイン
- 画像ローディングのアイコンアニメーション  
  あまり目にする機会はないけど、ちょっとかわいくしてみました。

## 難しかったポイント
- レイアウト
  - ポケモン図鑑の無限スクロール
    - 20件ずつ表示 
  - ポケモン図鑑らしいレイアウト
    - ウィジェットではNo、名前、画像、タイプ、分類、詳細を表示。アプリ内詳細では高さ、重さも追加表示。  
      ウィジェットは高さに制限があるからどこまでの情報を表示するか、要素間のマージ設定で高さも変わってくるので表示する  
      内容に悩みました。
  - ウィジェットとアプリ内画面のレイアウト共通化
    - ポケモン詳細の文字数に違いあがるので、ウィジェットでは最大3桁表示。アプリ内詳細ではすべてのポケモン詳細を表示できるようにした。
  - 端末ごとのレイアウト調整 
    - 端末の幅、高さが違うので小さい端末だとウィジェットに表示できる内容がすくなくなるので調整に悩みました。

## 今後について
- ウィジェットに表示された回数を図鑑の詳細画面にグラフで表示したらおもしろいかなと思っています。
- ライトモードの白がちょっと眩しいので、もうすこしトーンを落とした方が目に優しいかな。
- アプリ起動時にスプラッシュ画面でアイコンアニメーションさせたいかな。

## 使用API
* [Pokémon api](https://pokeapi.co/)

### サードパーティ
* [Alamofire](https://github.com/Alamofire/Alamofire)
* [realm-swift](https://github.com/realm/realm-swift)
* [SDWebImageSwiftUI](https://github.com/SDWebImage/SDWebImageSwiftUI)
* [Nimble](https://github.com/Quick/Nimble)
* [Quick](https://github.com/Quick/Quick)
