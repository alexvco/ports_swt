class Dictionary
  def initialize(data_file)
    @data_file = data_file
    read_file
  end

  def find_longest_word_stacked_tree
    @hash_with_length_as_key.keys.each do |key|
      log_process(key)
      words = @hash_with_length_as_key[key]
      words.each do |word|
        possible_trees = find_possible_permuted_trees(word: word)
        stack_tree     = find_full_stack_tree_in_trees(possible_trees)
        return stack_tree.reverse if stack_tree && stack_tree.count > 1
      end
    end
    []
  end

  private

  attr_reader :data_file

  def find_full_stack_tree_in_trees(trees)
    trees.values.reverse.find { |tree| has_full_stack_tree?(tree) }
  end

  def find_possible_permuted_trees(word: , possible_stacks: {}, previous_stack_key: nil)
    if possible_stacks.empty?
      previous_stack_key      = [word]
      possible_stacks[[word]] = [word]
    end

    possible_shorter_words = next_possible_shorter_words(word)
    new_stack              = create_new_stack_path(possible_stacks, previous_stack_key, word)
    return possible_stacks if has_full_stack_tree?(new_stack)
    find_next_possible_words(new_stack, possible_shorter_words, possible_stacks)

    possible_stacks
  end

  def create_new_stack_path(possible_stacks, previous_stack_key, word)
    new_stack                  = possible_stacks[previous_stack_key].dup.append(word).uniq
    possible_stacks[new_stack] = new_stack
    new_stack
  end

  def find_next_possible_words(new_stack, shorter_words, possible_stacks)
    return unless shorter_words.present?
    shorter_words.each do |possible_shorter_word|
      find_possible_permuted_trees(word:               possible_shorter_word,
                                   possible_stacks:    possible_stacks,
                                   previous_stack_key: new_stack)
    end
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

    File.readlines(data_file).each do |word|
      word.chomp!
      word.strip!
      next if word.empty?
      next if word.length < 3
      fill_hashes_with_word(word)
    end

    sort_hash_by_word_length
  end

  def fill_hashes_with_word(line)
    @hash_with_length_as_key[line.length] ||= []
    @hash_with_length_as_key[line.length] << line unless @hash_with_length_as_key[line.length].include?(line)
    @sorted_words[line.chars.sort.join] = line
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

  def sort_hash_by_word_length
    @hash_with_length_as_key = @hash_with_length_as_key.sort.reverse.to_h
  end

  def has_full_stack_tree?(new_stack)
    new_stack.last.length == 3
  end

  def log_process(key)
    Rails.logger.info("processing words with length: #{key}")
  end
end
