import { param } from "jquery";
import consumer from "./consumer"

//サーバ側のチャンネル（コントローラ的な）を購読する
const chatChannel = consumer.subscriptions.create("PostChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received: function(data) {//dataはどこから来るの?
    console.log(data['message'])
    // ↑ _message.html.erbがhtmlの形で出力される
    return $('#messages').append(data['message']); //ここで新しい情報を追加している。
  },

  speak: function(message) {
  //perform メソッドにより、フロントのデータをサーバーに送信することができます
  //第1引数にサーバー側のメソッド名、第2引数に送信するデータを指定
  //console.log(message)
    return this.perform('speak', {
      message: message //rails側で出すと
                       //speak({"message"=>{"message"=>"eeeeeeeee", "user_id"=>"1", post_id => "3"}})  こんな感じ。
                       //つまり下の$(document).on ...で書いているobjの内容が入る
      
    });
  }
});
//[data-behavior~=post_speaker]でイベントを取得するHTML要素を指定
$(document).on('keypress', '[data-behavior~=post_speaker]', function(event) {
  //フロントからのイベントを受け取る
  let obj = {}
  //入力データを取りたいけど.getElementById("input-data")で取れない
  //ここで取らなくてもいい？post_channel.rbのdata['message']['message']で取れる？
  obj.message = event.target.value //「e.target.value」でテキストボックスに打ち込んだ文字列を取得
  obj.user_id = event.target.getAttribute("data-user_id")
  // ↑ inputタグの属性を指定して値を取得している
  obj.post_id = event.target.getAttribute("data-post_id")
  // console.log(obj.user_id)

  if (event.keyCode === 13) {  //Enterキーが押下されたことを表す
    chatChannel.speak(obj);    //post_channel.jsのspeakアクションを発火   何が入る？ -> obj.message
    event.target.value = '';  

    //console.log(event.target)  //  -> <input type="text"...class data-behavior="post_speaker" data-user_id="1">が出力される
    return event.preventDefault();
  }
});


// data: { behavior: 'post_speaker' , "user_id": @post.user_id}