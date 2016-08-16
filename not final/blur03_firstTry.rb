class Image
	# refactored to use .each with index...
	attr_accessor :image_holder, :image_row_len, :image_col_len 

	def initialize(the_array)
		#stor the pic data (coming from the_array) and then get the size
		@image_holder = the_array
		@image_row_len = the_array.length
		@image_col_len = the_array[0].length
	end

	def output_image
		#Grab each row with an each do
		image_holder.each do |the_row|
			 puts the_row.join
		end
	end

	def blur(distance)
		t_list = []  #this is our list of points to blur...
		
		#get a list of points to blur
		row_count = 0
		image_holder.each do |the_row|
  			col_count = 0

  			the_row.each do |the_col_cell|
  				#check the_col_cell to see if its a 1
  				if the_col_cell == 1
	   				location = [row_count, col_count]
	   				t_list.concat [location]
  				end     
  				col_count += 1
  			end
  			row_count += 1
  		end
  		#now do the blurring
  		t_list.each do |the_loc|
			blur_it_man(the_loc[0],the_loc[1], distance)
		end

	end


	def blur_it_man(what_row, what_col, dist)
		
		row_length = (dist*2)+1
		puts "row_length is " + row_length.to_s

		#this gets the main row
		i = 0
		row_length.times do
			do_blur_to_image(what_row, (what_col-dist)+i) if (what_col-dist)+i >= 0
			i += 1

		end	

		#now go top down
		
		i = 0
		col_a = 2*i

		dist.times do
			start_col = what_col-i
			

			j=0
			puts "col_a is: " + col_a.to_s
			col_a.times do
				puts "in loop"
				if what_row-dist+i >= 0
					if start_col+j >=0 && start_col+j <= image_col_len-1
						do_blur_to_image(what_row-dist+i, start_col+j)
						puts "putting a 1 at " + (what_row-dist+i).to_s + " " + (start_col+j).to_s
					end
				end

				#do_blur_to_image(what_row+dist-i, start_col+j) if (what_row+dist-i <= (image_row_len-1)) && (start_col+j >=0 && start_col+j <= image_col_len-1)
				j += 1
			end
			i += 1

		end



	end



	def transform_image

		t_list = []  #this is our list of points to blur...

		#Grab each row -- and count it...
		row_count = 0

		image_holder.each do |the_row|
  			col_count = 0

  			the_row.each do |the_col_cell|
  				#check the_col_cell to see if its a 1
  				if the_col_cell == 1
  					#Get the location of the "1"
	   				location = [row_count, col_count]
	   				#Add it to a point list
	   				t_list.concat [location]
  				end     
  				col_count = col_count + 1
  			end
  			#Increase the row_count
  			row_count = row_count + 1
		end

		t_list.each do |the_loc|
			blur_it(the_loc[0],the_loc[1])
		end
	end



	def blur_it(what_row, what_col)
		do_blur_to_image(what_row-1, what_col) if what_row > 0
		do_blur_to_image(what_row+1, what_col) if what_row < (image_row_len-1)
		do_blur_to_image(what_row, what_col-1) if what_col > 0
		do_blur_to_image(what_row, what_col+1) if what_col < (image_col_len-1)
	end

	def do_blur_to_image(what_row, what_col)
		image_holder[what_row][what_col] = 1 if image_holder[what_row][what_col] == 0
	end
end

#First case for challenge
image_one_pixel = Image.new([
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
])
puts "***First Case...One pixel..."
image_one_pixel.output_image
image_one_pixel.blur(5)
puts "One pixel transformed..."
image_one_pixel.output_image

