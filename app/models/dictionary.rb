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

  def find_word_trees
    # stacked_trees = {}

    @hash_with_length_as_key.keys.each do |key|
      words = @hash_with_length_as_key[key]
      puts "key: #{key}"

      # stacked_trees[key] = {}
      words.each do |word|
        related_words = find_related_words(word)

        # puts "related_words: #{related_words}"

        # binding.pry if word == "traditionless"

        tree = find_tree_in_stack(related_words)
        # binding.pry if word == "generalizations"
        # puts "tree: #{tree}" if tree

        if tree
          return tree.reverse
          # stacked_trees[key][word] = tree
          # break
        end
      end
      # stacked_trees.delete(key) if stacked_trees[key].blank?
    end
    binding.pry
    # stacked_trees.values
    # longest_tree(stacked_trees)
    {}
  end

  private

  def find_tree_in_stack(hash)
    # binding.pry
    hash.values.find_all { |v| v.last.length == 3 }.last
  end


  def find_related_words(word, possible_stacks={}, original_word = nil, previous_word = nil)
    if original_word.nil?
      original_word = word
      previous_word = [word]
      possible_stacks[[word]] = [word]
      # puts "possible_stacks: #{possible_stacks}"
    end
    # puts ""
    # puts "----"
    # puts "word: #{word}"
    # puts "previous_word: #{previous_word}"

    applicable_words = find_related_word(word)

    # puts "possible_stacks FIRST: #{possible_stacks}"
    # puts "applicable_words: #{applicable_words}"

    # puts ""
    # puts "possible_stacks: #{possible_stacks}"
    # puts "previous_word: #{previous_word}"
    new_stack = possible_stacks[previous_word].dup.append(word).uniq
    # puts "new_stack: #{new_stack}"
    # puts ""
    possible_stacks[new_stack] = new_stack

    return possible_stacks if new_stack.last.length == 3
    # puts "new_stack: #{new_stack}"
    # puts "possible_stacks AFTER: #{possible_stacks}"
    # puts "----"
    # puts ""

    if applicable_words.present?
      applicable_words.each do |applicable_word|
        previous_word = new_stack
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
    # hash[hash.keys.max_by { |k| hash[k].keys.max }].max.last.reverse
    hash[hash.keys.max].values.flatten.reverse
  end

end

