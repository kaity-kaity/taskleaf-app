require "rails_helper"
require 'factory_bot_rails'

RSpec.describe TaskMailer, type: :mailer do
  let(:task) { FactoryBot.create(:task, name: 'メイラーSpecを書く', description: '送信したメールを確認します') }

  let(:text_body) do
    part = mail.body.parts.detect { |part| part.content_type == 'text/plain; charset=UTF-8' }
    part.body.raw_source
  end
  let(:html_body) do
    part = mail.body.parts.detect { |part| part.content_type == 'text/html; charset=UTF-8' }
    part.body.raw_source
  end


  describe '#creation_mail' do
    let(:mail) { TaskMailer.creation_mail(task) }
    it '想定どうりにメールが生成されている' do

      # ヘッダ
      expect(mail.subject).to eq('タスク作成完了メール')
      expect(mail.to).to eq(['user@example.com'])
      expect(mail.from).to eq(['taskleaf@example.com'])

      # text形式の本文
      expect(text_body).to match('以下のタスクを作成しました')
      expect(text_body).to match('メイラーSpecを書く')
      expect(text_body).to match('送信したメールを確認します')

      # html形式の本文
      expect(html_body).to match('以下のタスクを作成しました')
      expect(html_body).to match('メイラーSpecを書く')
      expect(html_body).to match('送信したメールを確認します')

    end
  end
end
