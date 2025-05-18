class ChatbotsController < ApplicationController
  def show
    @character_type = params[:character_type]
  end

  def generate_text
    @user_input = params[:user_input]
    character_type = params[:character_type]

    return unless @user_input.present?

    system_prompt = case character_type
    when "cat"
      <<~PROMPT
        猫っぽく話してください。内容は簡潔に短く話してください。
        山の情報を聞かれたら、その山の景色や展望の良い写真スポットも一緒に伝えてください。
      PROMPT
    when "oldman"
      <<~PROMPT
        おじいさんのような口調で話してください。内容は簡潔に短く話してください。
        山の情報を聞かれたら、その山の歴史や豆知識を一緒に話してください。
      PROMPT
    when "alien"
      <<~PROMPT
        関西弁で話してください。内容は簡潔に短く話してください。
        山の情報を聞かれたら、山の名前を教えてください。写真を撮るおすすめポーズを提案してください。
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
