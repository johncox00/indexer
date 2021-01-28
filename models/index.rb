require "lemmatizer"

class Index
  attr_accessor :the_index
  attr_accessor :documents

  def initialize
    @the_index = {}
    @documents = []
    @lem = Lemmatizer.new
  end

  def stop_words
    @stop_words ||= ["i", "me", "my", "myself", "we", "our", "ours", "ourselves", "you", "your", "yours", "yourself", "yourselves", "he", "him", "his", "himself", "she", "her", "hers", "herself", "it", "its", "itself", "they", "them", "their", "theirs", "themselves", "what", "which", "who", "whom", "this", "that", "these", "those", "am", "is", "are", "was", "were", "be", "been", "being", "have", "has", "had", "having", "do", "does", "did", "doing", "a", "an", "the", "and", "but", "if", "or", "because", "as", "until", "while", "of", "at", "by", "for", "with", "about", "against", "between", "into", "through", "during", "before", "after", "above", "below", "to", "from", "up", "down", "in", "out", "on", "off", "over", "under", "again", "further", "then", "once", "here", "there", "when", "where", "why", "how", "all", "any", "both", "each", "few", "more", "most", "other", "some", "such", "no", "nor", "not", "only", "own", "same", "so", "than", "too", "very", "s", "t", "can", "will", "just", "don", "should", "now"]
  end

  def parse_and_index(text)
    @documents << text
    words = normalize(text)
    words.each_with_index do |w, i|
      if !stop_words.include?(w)
        index_word(w, i)
      end
    end
  end

  def index_word(word, i)
    w = @lem.lemma(word)
    if @the_index[w]
      add(w, i)
    else
      insert(w, i)
    end
  end

  def insert(w, i)
    @the_index[w] = {occurrences: 1, docs: { @documents.length - 1 => [i] } }
  end

  def add(w, i)
    record = @the_index[w]
    record[:occurrences] += 1
    docs = record[:docs]
    if docs[@documents.length - 1]
      docs[@documents.length - 1] << i
    else
      docs[@documents.length - 1] = [i]
    end
  end

  def search(phrase)
    words = normalize(phrase) - stop_words
    puts @the_index.select { |key,_| words.include? key }
  end

  def normalize(words)
    words.gsub(/[^\w\s]/, '').downcase.split(' ')
  end
end
