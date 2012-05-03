#!/usr/bin/env ruby

# file: rxraw-lineparser.rb

module Enumerable
  def repeated_permutation(size, &blk)
    f = proc do |memo, &blk|
      if memo.size == size
        blk.call memo
      else
        self.each do |i|
          f.call memo + [i], &blk
        end
      end
    end

    if block_given?
      f.call [], &blk
    else
      Enumerator.new(f, :call, [])
    end
  end
end

class RXRawLineParser

  
  def initialize(format_mask)
    @format_mask = format_mask
  end
  
  def parse(line)

    field_names = @format_mask.to_s.scan(/\[!(\w+)\]/).flatten.map(&:to_sym)        

    patterns = possible_patterns(@format_mask)        
    patterns.each{|x| puts x.inspect }
    
    pattern = patterns.detect {|x| line.match(/#{x.join}/)}.join
    field_values = line.match(/#{pattern}/).captures      

    found_quotes = find_qpattern(pattern)

    if found_quotes then
      found_quotes.each {|i| field_values[i] = field_values[i][1..-2]}
    end        

    field_values += [''] * (field_names.length - field_values.length)

    [field_names, field_values]
  end

  private 
  
  def possible_patterns(format_mask)
    
    tot_fields = format_mask.scan(/\[!\w+\]/).length
    return [['(.*)']] if tot_fields <= 1
    main_fields = tot_fields - 1
    qpattern = %q{(["'][^"']+["'])}
    
    a = fmask_delimiters(format_mask)                                                       
    r = diminishing_permutation(main_fields)

    if r.length > 2 then
      itemx  = [r.slice!(-2)]
      r2 = r[0..-3] + itemx + r[-2..-1]
    else
      r2 = r
    end
    
    #puts 'r2'
    #r2.each{|x| puts x.inspect}
                               
    rr = r2.map do |x|
      x.each_with_index.map do |item, i|

        d = a[i]
        case item
          when  1
            i > 0 ? d + qpattern : qpattern
          when 0
            s = "([^%s]+)" % d
            i > 0 ? a[i-1] + s : s
        end
      end
    end

    rr.each{|x| puts x.inspect}

    count = 2**main_fields
    rr2 = rr.take(count+1).map {|x| x + [a[-1] + '(.*)']} 
    
    if rr.length > 2 then
      wild_r = rr2.slice!(-1)     
      rrr = rr2 + rr[0..count-1] + [wild_r] + rr[count..-1]    
    else
      rrr = rr2 + rr[0..count-1] +  rr[count..-1]          
    end
    
  end

  def diminishing_permutation(max_fields)
    result = max_fields.times.inject([]) do |r,i|
      r + [1,0].repeated_permutation(max_fields-i).to_a
    end
  end

  def find_qpattern(s)
    s.split(/(?=\([^\)]+\))/).map.with_index\
      .select{|x,i| x[/\["'\]\[\^"'\]\+\["'\]/] }.map(&:last)
  end
  
  def fmask_delimiters(f)
    a = f.split(/(?=\[!\w+\])/)[0..-2].map {|x| x[/\](.*)/,1] }
  end


end
