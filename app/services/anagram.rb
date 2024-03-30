class Anagram
    def initialize()
        @vowels = ["a", "i", "u", "e", "o"]
    end
    # スコアの計算
    def name_score(tmp_name, original_name)
        score = 0
        is_vowel = nil
        for s in tmp_name.split('') do
            # 初回は飛ばす
            if is_vowel == nil 
                # 現在の文字が母音が否か判定
                is_vowel = @vowels.include?(s)
                next
            end

            # 前の文字もしくは今の文字が母音の場合
            if is_vowel || @vowels.include?(s)
                score += 1             
            end

            # 現在の文字が母音が否か判定
            is_vowel = @vowels.include?(s)
            
        end
        
        score /= (tmp_name.length - 1)

        return score
    end
    # 交換するindexの指定
    def swap_to_any_neighbor(original_name)
        size = original_name.length
        for i in 0..size-2 do
            for j in i+1..size-1 do
                yield(i, j) 
            end
        end
    end
    # 名前 (name) 中の指定したindex ([i, j]) をswap
    def swap_name(name, swaps)
        name_ary = name.split('')
        ret = ""
        for i in 0..name.length-1 do 
            key = i
            # swap処理
            if i == swaps[0] 
                key = swaps[1] 
            elsif i == swaps[1] 
                key = swaps[0]
            end
            ret += name_ary[key]
        end
        return ret
    end
    def swap_two_base(local_best_name, original_name)
        best_score = -Float::INFINITY 
        best_name = local_best_name
        swap_to_any_neighbor(local_best_name){|i, j| 
            tmp_name = swap_name(local_best_name, [i, j])
            tmp_score = name_score(tmp_name, original_name)
            if best_score < tmp_score
                best_score = tmp_score
                best_name = tmp_name
            end
        }
        return best_name, best_score
    end
    # timesでswap_two_baseで交換する回数を指定する
    def local_search_base(original_name, times=nil)
        if times == nil
            times = original_name.length
        end

        best_score = -Float::INFINITY 
        best_name = original_name
        for _ in 1..times do
            tmp_name, tmp_score = swap_two_base(best_name, original_name)
            if best_score < tmp_score
                best_score = tmp_score
                best_name = tmp_name
            end
        end
        puts best_score, best_name
        return best_name
    end
end

