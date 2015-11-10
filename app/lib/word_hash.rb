module WordHash
  
  def self.build_trie(words)
    bw = {}
    
    words.each do |word|
      a = word.split('') << 'value'
      a.inject(bw) do |h, key |
        if h.has_key?(key) == false
          if key == 'value'
              h[key] = true
          else
              h[key] = {}
          end
        else 
          h[key]
        end
      end
        
    end
    return bw
  end
  
end