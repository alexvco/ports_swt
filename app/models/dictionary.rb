class Dictionary
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

  def find_longest_word_stacked_tree
    @hash_with_length_as_key.keys.each do |key|
      Rails.logger.info("processing words with length: #{key}")
      words = @hash_with_length_as_key[key]
      words.each do |word|
        possible_trees = find_possible_permuted_trees(word: word)
        stack_tree     = find_full_stack_tree_in_trees(possible_trees)
        return stack_tree.reverse if stack_tree
      end
    end
    {}
  end

  private

  attr_reader :data_file

  def find_full_stack_tree_in_trees(hash)
    hash.values.reverse.find { |v| v.last.length == 3 }
  end

  def find_possible_permuted_trees(word: word, possible_stacks: {}, previous_stack_key: nil)
    if possible_stacks.empty?
      previous_stack_key      = [word]
      possible_stacks[[word]] = [word]
    end

    possible_shorter_words     = next_possible_shorter_words(word)
    new_stack                  = possible_stacks[previous_stack_key].dup.append(word).uniq
    possible_stacks[new_stack] = new_stack
    return possible_stacks if new_stack.last.length == 3

    if possible_shorter_words.present?
      possible_shorter_words.each do |possible_shorter_word|
        find_possible_permuted_trees(word: possible_shorter_word, possible_stacks: possible_stacks, previous_stack_key: new_stack)
      end
    end

    possible_stacks
  end

  def next_possible_shorter_words(word)
    possible_shorter_words = []
    shorter_permutations   = shorter_permutations_of_word(word)
    shorter_permutations.each do |permutation|
      if @sorted_words[permutation.chars.sort.join]
        possible_shorter_words << @sorted_words[permutation.chars.sort.join]
      end
    end
    possible_shorter_words
  end

  def read_file
    @hash_with_length_as_key = {}
    @sorted_words            = {}

    File.readlines(data_file).each do |line|
      line.chomp!
      line.strip!
      next if line.empty?
      next if line.length < 3

      @hash_with_length_as_key[line.length] ||= []
      @hash_with_length_as_key[line.length] << line unless @hash_with_length_as_key[line.length].include?(line)
      @sorted_words[line.chars.sort.join] = line
    end

    @hash_with_length_as_key = @hash_with_length_as_key.sort.reverse.to_h
  end

  def shorter_permutations_of_word(string)
    arr = []
    (0..string.length - 1).each do |i|
      str = string.dup
      str.slice!(i)
      arr << str.chars.sort.join.strip
    end
    arr.uniq
  end
end
