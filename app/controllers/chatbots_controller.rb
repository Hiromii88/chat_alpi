class ChatbotsController < ApplicationController
  def show
    @character_type = params[:character_type]
  end

  PREFECTURES = %w[
    青森 愛媛 茨城 岐阜 九州 熊本 群馬 甲信越 高知 関西 関東 岩手 宮崎 宮城
    京都 近畿 熊本 山形 山梨 四国 滋賀 静岡 埼玉 三重 石川 千葉 中国 長崎 長野
    中央アルプス 中部 鳥取 徳島 東京 東北 東海 奈良 新潟 福井 福岡 福島 富山
    北アルプス 北海道 北陸 八ヶ岳 尾瀬 岡山 奥秩父 鹿児島
  ]

  def extract_prefecture(user_input)
    PREFECTURES.find { |pref| user_input.include?(pref) }
  end

  def generate_text
    @user_input = params[:user_input]
    character_type = params[:character_type]

    return unless @user_input.present?

    prefecture = extract_prefecture(@user_input)

    mountains = if prefecture
                  Mountain.where("area LIKE ?", "%#{prefecture}%")
                else
                  []
                end

    mountain_info = mountains.map { |m| "#{m.name}（#{m.prefecture}）: #{m.feature}" }.join("\n")

    system_prompt = case character_type
    when "cat"
        <<~PROMPT
            あなたは猫のようなキャラクターです。語尾に「にゃ」などを付けて、フレンドリーに、相手に時々質問しつつ、会話を楽しんでください。
            おすすめの山の名前を1個挙げたら、その山のおすすめの景色も一緒に教えてください。
            内容は簡潔に短く話してください。

            以下は該当する山の情報です：
            #{mountain_info}

            3個の山を紹介した後、以下のURLを含めて「山の情報をもっと見たい方はこちら」と案内してください：
            https://your-domain.com/mountains
        PROMPT

    when "oldman"
        <<~PROMPT
            あなたは物知りなおじいさんキャラクターです。穏やかで親しみやすく広島弁で、相手に時々質問しつつ、会話を楽しんでください。
            おすすめの山の名前を1個挙げたら、その山の豆知識を一言で話してください。
            内容は簡潔に短く話してください。

            以下は該当する山の情報です：
            #{mountain_info}

            3個の山の名前を出したら必ず、以下のように書いてください：
            「詳しくはこちら → https://your-domain.com/mountains」
        PROMPT

    when "alien"
        <<~PROMPT
            あなたは関西弁を話すフレンドリーな宇宙人です。ちょっとおちゃめで、ツッコミも交えつつ、相手に時々質問しつつ、会話を楽しんでください。
            おすすめの山の名前を1個挙げて、その山で写真を撮るときのおすすめポーズを一言で紹介してください。
            内容は簡潔に短く話してください。

            以下は該当する山の情報です：
            #{mountain_info}

            3個の山を紹介した後、以下のURLを含めて「山の情報をもっと見たい方はこちら」と案内してください：
            https://your-domain.com/mountains
        PROMPT
    else
        "関西弁で、フレンドリーに返答してください。まずは相手の登山歴や行きたい場所を聞き出して、そこから話を広げてください。"
    end

    client = OpenAI::Client.new
    response = client.chat(
      parameters: {
        model: "gpt-4.1-nano",
        messages: [
          { role: "system", content: system_prompt },
          { role: "user", content: @user_input }
        ],
        temperature: 0.7,
        max_tokens: 70
      }
    )

    @generated_text = response.dig("choices", 0, "message", "content")
    render json: { text: @generated_text }
  end
end
