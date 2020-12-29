class TextBroadcastJob < ApplicationJob
  queue_as :default

  def perform(text)
    ActionCable.server.broadcast 'post_channel', text: render_text(text)
  end

  private

    def render_text(text)
      ApplicationController.renderer.render partial: 'texts/text', locals: { text: text }
    end
end
