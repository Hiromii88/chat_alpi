class CharactersController < ApplicationController
  def select
    case params[:character_type]
    when "cat"
      name = "にゃん"
      icon = "cat_icon.png"
    when "oldman"
      name = "じぃ"
      icon = "oldman_icon.png"
    when "alien"
      name = "うちゅ"
      icon = "alien_icon.png"
    end
    # キャラ情報をセッションに保持（ログイン不要でも使える）
    session[:character] = {
      name: name,
      icon: icon
    }

    # チャット画面にリダイレクト
    redirect_to chatbots_show_path
  end
end
