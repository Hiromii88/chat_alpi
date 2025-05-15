class ChatbotsController < ApplicationController

  def show
  end

  def generate_text
    @user_input = params[:user_input]

    if @user_input.present?
      client = OpenAI::Client.new
      response = client.chat(
        parameters: {
          model: "gpt-4.1-nano",
          messages: [
            { role: "system", content: "関西弁で、短く簡潔に返答してください" },
            { role: "user", content: @user_input }
          ],
          temperature: 0.7, max_tokens: 200
        }
      )
      @generated_text = response.dig("choices", 0, "message", "content")
      render json:{text: @generated_text}
    end
  end
end
