class ItemsController < ApplicationController
    def create        
        # カテゴリ名をパラメータから取得
        category_name = item_params[:category_name]
        # カテゴリが存在しない場合は新規作成
        category = Category.find_or_create_by(name: category_name)
      
        # Itemの新規作成時に関連付け
        @item = Item.new(item_params.except(:category_name))
        @item.category = category
        if !category.save
            render json: { error: 'Failed to create category' }, status: :internal_server_error
            return
        end
            
      
        if @item.save
          render json: @item, status: :created  # 成功した場合、201 Created ステータスを返す
        else
          render json: @item.errors, status: :unprocessable_entity  # エラーがある場合、422 Unprocessable Entity ステータスを返す
        end
    end
  
    def index
      unless params[:user_id].present?
        return render json: { error: 'user_id is required' }, status: :bad_request
      end
      @items = Item.where(user_id: params[:user_id])  # user_idでフィルタリング
  
      # カテゴリー名を含む形式でアイテムを整形
      @items = @items.includes(:category).map do |item|
        {
          id: item.id,
          display_name: item.display_name,
          generic_name: item.generic_name,
          status: item.status,
          category_name: item.category.name,  # categoryのnameを取得
          user_id: item.user_id
        }
      end
  
      render json: @items  # JSON形式で返す
    end
  
    private
  
    def item_params
      params.require(:item).permit(:category_name, :display_name, :generic_name, :status, :user_id)  # Strong Parameters
    end
  end
  