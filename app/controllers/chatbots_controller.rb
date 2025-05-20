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

    # 都道府県名を抽出
    prefecture = extract_prefecture(@user_input)

    # マッチしたら検索、それ以外はnil
    mountains = if prefecture
                  Mountain.where("prefecture LIKE ?", "%#{prefecture}%")
                else
                  []
                end

    # mountainデータをプロンプトに組み込む（任意）
    mountain_info = mountains.map { |m| "#{m.name}（#{m.prefecture}）: #{m.feature}" }.join("\n")

    system_prompt = case character_type
    when "cat"
      <<~PROMPT
        猫っぽく話してください。内容は簡潔に短く話してください。
        山の話をしたら、おすすめの山の名前を２個挙げて、景色や展望の良い写真スポットも一緒に伝えてください。
        以下は該当する山の情報です：
        #{mountain_info}
      PROMPT
    when "oldman"
      <<~PROMPT
        おじいさんのような口調で話してください。内容は簡潔に短く話してください。
        山の話をしたら、おすすめの山の名前を２個挙げて、歴史や豆知識を一緒に話してください。
        以下は該当する山の情報です：
        #{mountain_info}
      PROMPT
    when "alien"
      <<~PROMPT
        関西弁で話してください。内容は簡潔に短く話してください。
        山の話をしたら、おすすめの山の名前を２個挙げて、写真を撮るおすすめポーズを提案してください。
        以下は該当する山の情報です：
        #{mountain_info}
      PROMPT
    else
      "関西弁で、短く簡潔に返答してください"
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
        max_tokens: 200
      }
    )

    @generated_text = response.dig("choices", 0, "message", "content")
    render json: { text: @generated_text }
  end
end
