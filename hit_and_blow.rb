# hit&blow
# ルール
# ランダムな指定の桁数の数値を当てるゲーム
# 答えにに含まれる数字を入れたけど、桁が違う場合はblow
# 答えに含まれて桁数も合っている場合はhit
# 最終的に全桁でhitすれば終了

def main
    # 答えの桁数
    answer_length = 4
    # 答え
    answer = ""
    while answer.length != answer_length do
        random_str = rand(9).to_s
        answer += random_str unless answer.include?(random_str)
    end
    # puts "答え："  + answer

    # 開始メッセージ
    puts "Hit&Blowを開始します"
    puts "答えは#{answer_length}桁です"

    1.step do |loop_count|

        # ユーザー入力
        print "予想#{answer_length}桁を入力してください>> "
        user_input = gets.chomp

        # バリデーションチェック
        error_messages = []
        error_messages << "数値を入力してください" unless user_input =~ /^[0-9]+$/
        error_messages << "入力桁数が#{answer_length}ではありません" unless user_input.length == answer_length
        user_input.each_char do |ch|
            error_messages << "同じ数字が入力されています" unless user_input.count(ch) == 1
            break unless user_input.count(ch) == 1
        end
        puts error_messages unless error_messages.empty?
        next unless error_messages.empty?

        # hitとblowの判定
        hit = 0
        blow = 0
        user_input.each_char.with_index do |ch, i|
            hit += 1 if answer.include?(ch) and answer.index(ch) == i
            blow += 1 if answer.include?(ch) and answer.index(ch) != i
        end
        puts "Hit:#{hit}、Blow:#{blow}"

        # 結果出力
        puts "正解！終了！#{loop_count}回目でクリアしました！" if hit == answer_length
        break if hit == answer_length
    end
end

if __FILE__ == $0
    main
end