class JobPostsController < ApplicationController
  JobPost = Struct.new(:id, :source)

  # @param [Integer] user_id アクセスしたユーザーのID
  # @param [Integer] page ページ番号（1から始まる）
  # @param [Integer] per_page 1ページあたりの要求するアイテム数（基本は10だが、場合によって異なる）
  # @return [Array<JobPost>] 募集のリスト
  def interleaving(user_id, page, per_page)
    # ここに実装を追加してください
    # 以下のように、「募集のID」と「どのアルゴリズム由来の募集かを表す文字列等」のペアの配列を返してください
    # [
    #   JobPost.new(id: 1, source: :new_algorithm),
    #   JobPost.new(id: 15, source: :old_algorithm),
    # ]

    # Step 1: 両モデルのランキングを十分な件数取得
    # 本番ではキャッシュやバッチ処理で取得される想定
    # 「ランキング全体をインターリーブしてからページング」するという設計方針に基づき全体を取得
    # 1000件程度返すのは十分実用的な範囲と考える
    new_ids = new_algorithm(user_id, 1, 1000)
    old_ids = old_algorithm(user_id, 1, 1000)

    # Step 2: 重複を排除しながら Balanced Interleaving を実施
    seen_ids = {}        # 表示済み ID を記録するハッシュ
    merged = []          # インターリーブ結果リスト
    na_idx = 0           # new_algorithm 側の現在の位置
    oa_idx = 0           # old_algorithm 側の現在の位置
    # total_expected = (new_ids + old_ids).uniq.size  # new_algorithm と old_algorithm の両方から返された ID の中で、重複を除いたユニークな ID の数
    target_size = (page - 1) * per_page + per_page # 必要件数(少しでも処理を軽くする)

    # new, old の両方を交互に処理しながらマージ
    # 必要なサイズが merged に追加されるまで繰り返す
    # while merged.size < total_expected
    while merged.size < target_size
      # new_ids のリストを先頭から順に見ていき、まだ使っていないIDを1つ追加する
      while na_idx < new_ids.size
        id = new_ids[na_idx] # 現在のインデックスにあるIDを取得
        na_idx += 1 # 次に見る位置を1つ進めておく
        unless seen_ids[id] # このIDがまだ追加されていなければ（重複防止）
          # JobPost オブジェクトを作成して merged に追加（new_algorithm由来として）
          merged << JobPost.new(id: id, source: :new_algorithm)
          seen_ids[id] = true # このIDはすでに使用済みと記録しておく
          break # 追加されたら終了
        end
      end

      # old_algorithm 側から候補を取り出す
      while oa_idx < old_ids.size
        id = old_ids[oa_idx]
        oa_idx += 1
        unless seen_ids[id]
          merged << JobPost.new(id: id, source: :old_algorithm)
          seen_ids[id] = true
          break
        end
      end
    end

    # Step 3: ページング処理
    offset = (page - 1) * per_page # ページの先頭が merged の中で何番目かを計算
    paged = merged[offset, per_page] || [] # ページが存在しない場合でも、エラーにせず空配列を返す

    # Step 4: 最終的な結果を返す（per_page 件数以内)
    return paged[0...per_page]
      
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

end

