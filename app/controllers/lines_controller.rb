class LinesController < ApplicationController
  
  def index
    @lines = Line.all
    @from_to = ''
    @arr_all= ''
  end
 
  def select_line
    # https://docs.google.com/document/d/1bx1yNyuDw6D47fAgy-L2Za_BXtqyHrxna0xpWNKvS7o/edit
  	@lines = Line.all
    @start = params[:line][:from]
    @start = 'no way' if @start.nil?
    @end = params[:line][:to]
    @end = 'no way' if @end.nil?
    
    @from_to = 'no way'
    @arr_km = []
    @arr_min = []
    
    @from_to = 'From ' + @start + ' to ' + @end + ' : 0 km & 0 min' if params[:line][:from] == params[:line][:to]
    
    if @from_to == 'no way'
      from_to = @start + @end
      to_from = @end + @start

      @i = 1
      i = 0
      @x1 = 0
      @x2 = 0

      @arr_all = []
      @arr_from = []

      @lines.each do |l1|
        str = l1.line
        if str.include?(from_to) || str.include?(to_from)
          str = str[1] + str[0] unless str[0] == @start
          @arr_all << str
        else
          if str.include?(@start)
            str = str[1] + str[0] unless str[0] == @start
            @arr_from << str
            @i = @arr_from.length

            while @arr_from.length > 0 do
              @arr_size = @arr_from.length

              @arr_from.each_with_index do |el_arr, index|
                if el_arr.include?(@end)
                 @arr_all << el_arr
                  @arr_from.delete_at(index)
                  @x1 = @x1 + 1
                else
                  @lines.each do |l2|
                    str1 = l2.line
                    str2 = el_arr
                    if str1.include?(str2[str2.length-1])
                      len = str2.length-1
                    
                      len.times do |ind|
                        i = 1 if str1.include?(el_arr[ind])
                      end
                      if i == 0
                        str1 = str1[1] + str1[0] unless str1[0] == el_arr[el_arr.length-1]
                        str1 = el_arr + str1
                        @arr_from << str1
                        @x2 = @x2 + 1
                      end

                      i = 0

                    end
                  end

                end
              end

              @arr_size.times do
                @arr_from.shift
              end
            end

          end
        end
      end
      @arr_all = @arr_all.uniq
      
      @arr_all.each do |ell_arr|
        st = 0
        el_km = 0
        el_min = 0

        len = (ell_arr.length)/2

        len.times do
          ell1 = ell_arr[st] + ell_arr[st+1]
          ell2 = ell_arr[st+1] + ell_arr[st]
          @lines.each do |l3|
            str = l3.line
            if str.include?(ell1) || str.include?(ell2)
              el_km = el_km + l3.kilometers
              el_min = el_min + l3.minutes
            end
          end

          st = st + 2
          
        end
        @arr_km << el_km
        @arr_min << el_min
      end

      @min_km = @arr_km[0]
      @min_min = @arr_min[0]

      @arr_km.each_with_index do |e_km|
        @min_km = e_km if @min_km > e_km
      end
      @arr_min.each_with_index do |e_min|
        @min_min = e_min if @min_min > e_min
      end
      
      @min_km_from_to = @arr_all[@arr_km.index(@min_km)].split(//)
      @min_km_from_to = @min_km_from_to.uniq

      @min_min_from_to = @arr_all[@arr_min.index(@min_min)].split(//)
      @min_min_from_to = @min_min_from_to.uniq

      @from_to = 'From ' + @start + ' to ' + @end

    end

    

    render 'index'
    # redirect_to :back
  end

end
