#Introducing the RecordX Raw-line parser

    require 'rxraw-lineparser'

    format_mask =  "[!name] [!age] [!telno]"
    rxp = RXRawLineParser.new(format_mask)
    rxp.parse("Dan")
    #=> [[:name, :age, :telno], ["Dan", "", ""]]

    rxp.parse "Bob 44"
    #=> [[:name, :age, :telno], ["Bob", "44", ""]]

    rxp.parse "Jill 87 0245 673 8532"
    #=> [[:name, :age, :telno], ["Jill", "87", "0245 673 8532"]]

    rxp.parse "'Dan Brown' 55 554334"
    #=> [[:name, :age, :telno], ["Dan Brown", "55", "554334"]]

    rxp.parse "'Dan Brown' '55 yrs old' 554334"
    #=> [[:name, :age, :telno], ["Dan Brown", "55 yrs old", "554334"]]

    rxp.parse "Dan '55 yrs old' 554334"
    #=> [[:name, :age, :telno], ["Dan", "55 yrs old", "554334"]]

    rxp.parse '"Anne Todd" 44'
    #=> [[:name, :age, :telno], ["Anne Todd", "44", ""]]
