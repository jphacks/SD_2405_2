class ItemsController < ApplicationController
    def create
        # 消費期限日数から消費期限日を計算
        shelf_life_days = params[:shelf_life_days].to_i
        expiry_date = Date.today + shelf_life_days.days
        # category_nameを取得
        category_name = params[:category_name].to_s

        # カテゴリが存在しない場合は新規作成
        category = Category.find_or_create_by(name: category_name)
      
        # Itemの新規作成時に関連付け
        @item = Item.new(item_params.merge(expiry_date: expiry_date))
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
          expiry_date: item.expiry_date
        }
      end
  
      render json: @items  # JSON形式で返す
    end
  
    private
  
    def item_params
      params.require(:item).permit(:display_name, :generic_name, :status, :user_id)  # Strong Parameters
    end
  end
  