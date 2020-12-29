class PostChannel < ApplicationCable::Channel
  # before_action :set_text, only: [:speak]
  def subscribed
    
    stream_from "post_channel#{params['post']}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    print("=========")
    print(data) #{"text"=>{"text"=>"eeeeeeeee", "user_id"=>"1"}, "action"=>"speak"}が取れる
    #つまりpost_channel.jsの$(document).on ...のobjが同ファイルのspeak関数を通ってここにきた。

    #_text.html.erbで表示される内容に関係する。
    Text.create! content: data['text']['message'], user_id: data['text']['user_id'], post_id: data['text']['post_id'], name: data['text']['name']   #params['post']
         #上のデータはどう確認する？  #jsonの値の取り方に注意。data['user_id']だけじゃ取れない。
  end

  # def set_text
  #   @text = Text.find(params[:id])
  # end

  # # Only allow a list of trusted parameters through.
  # def text_params
  #   params.require(:text).permit(:content, :user_id, :post_id)
  # end

end