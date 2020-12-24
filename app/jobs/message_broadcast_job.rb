class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    print("oooooooooooooooooooo")
    #messageの内容を取得している
    ActionCable.server.broadcast 'post_channel', message: render_message(message)  #ここに追加で@profileを引数で持たせるとユーザの名前も取れる
                                                                      #messageモデルの MessageBroadcastJob.perform_later self でself以外に@profileを持たせてもいい
  end

  private

    def render_message(message)
      ApplicationController.renderer.render partial: 'messages/message', locals: { message: message }
    end
end
