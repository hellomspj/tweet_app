class JobPostsController < ApplicationController
  JobPost = Struct.new(:id, :source)

  # @param [Integer] user_id アクセスしたユーザーのID
  # @param [Integer] page ページ番号（1から始まる）
  # @param [Integer] per_page 1ページあたりの要求するアイテム数（基本は10だが、場合によって異なる）
  # @return [Array<JobPost>] 募集のリスト
  def interleaving(user_id, page, per_page)
    # ここに実装を追加してください
    # 以下のように、「募集のID」と「どのアルゴリズム由来の募集かを表す文字列等」のペアの配列を返してください
    [
      JobPost.new(id: 1, source: :new_algorithm),
      JobPost.new(id: 15, source: :old_algorithm),
    ]
  end


  # @param [Integer] user_id アクセスしたユーザーのID
  # @param [Integer] page ページ番号（1から始まる）
  # @param [Integer] per_page 1ページあたりの要求するアイテム数（基本は10だが、場合によって異なる）
  # @return [Array<Integer>] 募集のIDのリスト
  def new_algorithm(user_id, page, per_page)
    # 具体的なランキングアルゴリズムの実装は不要です
    # 適当なIDのリストを返すスタブを実装してください
    # 例:
    ids = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30]
    ids[(page - 1) * per_page..page * per_page - 1]
  end


  # old_algorithmメソッド
  # new_algorithmと同様
  def old_algorithm(user_id, page, per_page)
    # 具体的なランキングアルゴリズムの実装は不要です
    # 適当なIDのリストを返すスタブを実装してください
    # 例:
    ids = [15, 21, 6, 23, 30, 1, 7, 14, 29, 12, 24, 18, 10, 13, 20, 3, 22, 27, 26, 11, 4, 5, 9, 17, 28, 8, 2, 19, 16, 25]
    ids[(page - 1) * per_page..page * per_page - 1]
  end


  def interleaving(user_id, page, per_page)
    
  end
end

