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

    stacked_trees = { }

    candidates.each do |candidate|
      stacked_trees[candidate] ||= {}

      puts "candidate: #{candidate.inspect}"
      puts ""

      @hash_with_length_as_key.keys.drop(1).each do |key|
        words = @hash_with_length_as_key[key]
        words.each do |word|
          break if stacked_trees[candidate].keys.include?(word.length)

          permutations     = remove_string(word)
          permutations.each do |perm|
            #perm exists in dictionnary?
            if @sorted_words[perm.chars.sort.join]
              stacked_trees[candidate][word.length] = @sorted_words[perm.chars.sort.join]
              break
            end
          end
        end
      end
    end
    binding.pry
  end

  def find_word_trees
    stacked_trees = {}

    @hash_with_length_as_key.keys.each do |key|
      words = @hash_with_length_as_key[key]
      puts "key: #{key}"

      stacked_trees[key] = {}
      words.each do |word|
        related_words = find_related_words(word)
        related_words.prepend(word)
        stacked_trees[key][word] = related_words if related_words.count > 1
      end
    end
    # binding.pry
    puts "stacked_trees: #{stacked_trees}"
    # stacked_trees.values
    # longest_tree(stacked_trees)
  end

  private

  def find_related_words(word, related_words=[])
    puts "word: #{word}"

    applicable_words = []
    permutations     = remove_string(word)
    permutations.each do |perm|
      #perm exists in dictionnary?
      if @sorted_words[perm.chars.sort.join]
        applicable_words << @sorted_words[perm.chars.sort.join]
      end
    end

    if applicable_words.present?
      related_word = applicable_words.last

      puts ""
      puts "related_word: #{related_word}"
      puts "related_word.length: #{related_word.length}"
      puts "related_words.group_by {|l| l.length}: #{related_words.group_by { |l| l.length }}"
      puts "related_words.group_by {|l| l.length}.keys: #{related_words.group_by { |l| l.length }.keys}"
      puts "related_words.group_by {|l| l.length}.keys.include?(related_word.length): #{related_words.group_by { |l| l.length }.keys.include?(related_word.length)}"
      puts ""

      related_words << related_word
      find_related_words(related_word, related_words)
    end

    related_words.flatten
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
    # @hash_with_length_as_key = @hash_with_length_as_key.sort.reverse.to_h
    @hash_with_length_as_key = @hash_with_length_as_key.sort.to_h
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

