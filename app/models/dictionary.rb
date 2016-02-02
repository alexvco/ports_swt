class Dictionary

  attr_reader :data_file

  def initialize(data_file)
    @data_file = data_file
    read_file
  end

  def word_exists_in_dictionary?(word)
    @hash_with_word_as_key[word]
  end

  def find_words_with_length(length)
    @hash_with_length_as_key[length] || []
  end

  def find_possible_stacks
    candidates = @hash_with_length_as_key[3]

    stacked_trees = {}

    @max = @hash_with_length_as_key.keys.max

    ["ire"].each do |candidate|
      # stacked_trees[candidate] ||= {}
      stacked_trees[candidate] ||= []

      puts "candidate: #{candidate.inspect}"
      puts ""

      @length = candidate.length
      @search = candidate

      while @length < @max
        words   = @hash_with_length_as_key[@length]
        @length += 1
        next if words.blank?
        # binding.pry
        words.each do |word|
          # break if stacked_trees[candidate].keys.include?(word.length)

          puts "word: #{word}"

          permutations = remove_string(word)
          permutations.each do |perm|
            #perm exists in dictionnary?
            puts ""
            puts "@search: #{@search}"
            puts "@search.chars.sort.join: #{@search.chars.sort.join}"
            puts "perm.chars.sort.join: #{perm.chars.sort.join}"
            puts "@sorted_words[perm.chars.sort.join]: #{@sorted_words[perm.chars.sort.join]}"
            puts ""
            if perm.chars.sort.join == @search.chars.sort.join
              # binding.pry
              puts "found word: #{word}"
              stacked_trees[candidate] << word
              @search = word
              # binding.pry if word == "oriels"
              break
            end
          end
        end

        puts "@length: #{@length}"
        puts "@max: #{@max}"
      end
    end

    puts "stacked_trees: #{stacked_trees.inspect}"
  end

  def find_word_trees
    stacked_trees = {}

    @hash_with_length_as_key.keys.each do |key|
      words = @hash_with_length_as_key[key]
      puts "key: #{key}"

      stacked_trees[key] = {}
      words.each do |word|
        related_words = find_related_words(word)
        binding.pry if word == "traditionless"
        related_words.prepend(word)
        if related_words.count > 1 && related_words.last.length == 3
          stacked_trees[key][word] = related_words
        end
      end
      stacked_trees.delete(key) if stacked_trees[key].blank?
    end
    # binding.pry
    puts "stacked_trees: #{stacked_trees}"
    # stacked_trees.values
    longest_tree(stacked_trees)
  end

  private

  def find_related_words(word, possible_stacks=[], original_word = nil, previous_word = nil)
    if original_word.nil?
      original_word = word
      possible_stacks << original_word
    end

    applicable_words = find_related_word(word)

    if applicable_words.present?
      applicable_words.each do |applicable_word|
        new_stack = possible_stacks.flatten.dup.uniq.append(applicable_word).uniq
        possible_stacks << new_stack
        return new_stack if new_stack.last.length == 3
        puts ""
        puts "applicable_word: #{applicable_word}"
        # puts "applicable_words: #{applicable_words}"
        puts ""
        find_related_words(applicable_word, possible_stacks, original_word, previous_word)
      end
    end

    possible_stacks
  end

  def find_related_word(word)
    applicable_words = []
    permutations     = remove_string(word)
    permutations.each do |perm|
      #perm exists in dictionnary?
      if @sorted_words[perm.chars.sort.join]
        applicable_words << @sorted_words[perm.chars.sort.join]
      end
    end
    applicable_words
  end

  def find_recursive_related_word(word, related=[])
    words = find_related_word(word)

    while words.count > 0
      words.each do |w|
        words = find_related_word(w)
        related << words
      end
    end
    related
  end

  def read_file
    @hash_with_length_as_key = {}
    @permutations            = {}
    @sorted_words            = {}

    File.readlines(data_file).each do |line|
      line.chomp!
      line.strip!
      next if line.empty?
      next if line.length < 3

      @hash_with_length_as_key[line.length] ||= []
      @hash_with_length_as_key[line.length] << line unless @hash_with_length_as_key[line.length].include?(line) #traditionless

      # @sorted_words[line.chars.sort.join] ||= []
      @sorted_words[line.chars.sort.join] = line

    end
    @hash_with_length_as_key = @hash_with_length_as_key.sort.reverse.to_h
    # @hash_with_length_as_key = @hash_with_length_as_key.sort.to_h
  end

  def remove_string(string)
    arr = []
    (0..string.length - 1).each do |i|
      str = string.dup
      str.slice!(i)
      arr << str.chars.sort.join.strip
    end
    arr.uniq
  end

  def permutes_from?(longer, shorter)
    perms = @permutations[longer]
    return false if perms.blank?
    perms.each do |perm|
      return true if perm.chars.sort == shorter.chars.sort
    end
    false
  end

  def longest_tree(hash)
    hash[hash.keys.max_by { |k| hash[k].keys.max }].max.last.reverse
  end

end

