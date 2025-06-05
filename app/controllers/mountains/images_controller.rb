module Mountains
  class ImagesController < ApplicationController
    def destroy
      mountain = Mountain.find(params[:mountain_id])
      mountain.image.purge
      redirect_to mountain_path(mountain), notice: "画像を削除しました"
    end
  end
end
