class Text < ApplicationRecord
    validates :content, presence: true
    # createの後にコミットする { TextBroadcastJobのperformを遅延実行 引数はself }
    after_create_commit { TextBroadcastJob.perform_later self }
    #TextBroadcastJobBroadcastJob.perform_later self でself以外に@profileを持たせてもいい
    #selfはコメント欄に書かれたメッセージの内容
    # belongs_to :post
    # belongs_to :user
end
