class ItemsController < ApplicationController
  def create
    # 消費期限日数から消費期限日を計算
    shelf_life_days = params[:shelf_life_days].to_i
    expiry_date = Date.today + shelf_life_days.days
    
    # category_namesを配列で取得し、存在しないカテゴリは新規作成
    category_names = params[:category_names] || []
    categories = category_names.map do |category_name|
      Category.find_or_create_by(name: category_name)
    end
  
    # Itemを新規作成し、消費期限とカテゴリを関連付け
    @item = Item.new(item_params.merge(expiry_date: expiry_date))
  
    # Transactionを使用して一括保存
    ActiveRecord::Base.transaction do
      @item.save!
      @item.categories << categories  # N:N 関連付けを保存
    end
  
    # 成功レスポンスを返す
    render json: @item, status: :created
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.record.errors }, status: :unprocessable_entity
  rescue => e
    render json: { error: 'Failed to create item or categories' }, status: :internal_server_error
  end
  
  def index
    unless params[:user_id].present?
      return render json: { error: 'user_id is required' }, status: :bad_request
    end
  
    @items = Item.where(user_id: params[:user_id])  # user_idでフィルタリング
  
    # カテゴリー名を含む形式でアイテムを整形
    @items = @items.includes(:categories).map do |item|
      {
        id: item.id,
        display_name: item.display_name,
        generic_name: item.generic_name,
        status: item.status,
        category_names: item.categories.map(&:name),  # 複数のカテゴリー名を取得
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
  