class PostChannel < ApplicationCable::Channel
  # before_action :set_message, only: [:speak]
  def subscribed
    
    stream_from "post_channel#{params['post']}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    print("=========")
    print(data) #{"message"=>{"message"=>"eeeeeeeee", "user_id"=>"1"}, "action"=>"speak"}が取れる
    #つまりpost_channel.jsの$(document).on ...のobjが同ファイルのspeak関数を通ってここにきた。
    print("=========")
    params['post']
    #_message.html.erbで表示される内容に関係する。
    Message.create! content: data['message']['message'], user_id: data['message']['user_id'], post_id: data['message']['post_id']#params['post']
    print("--------------------------")               #上のデータはどう確認する？  #jsonの値の取り方に注意。data['user_id']だけじゃ取れない。
    #print(params['post']) #これ何？
  end

  # def set_message
  #   @message = Message.find(params[:id])
  # end

  # # Only allow a list of trusted parameters through.
  # def message_params
  #   params.require(:message).permit(:content, :user_id, :post_id)
  # end

end