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

		#this gets the main row
		i = 0
		row_length.times do
			do_blur_to_image(what_row, (what_col-dist)+i) if (what_col-dist)+i >= 0
			i += 1
		end	

		#now go top down
		i = 0
		dist.times do
			cols_across = (2*i)+1
			start_col = what_col-i
			col_count = 0
			cols_across.times do
				do_blur_to_image(what_row-dist+i, start_col+col_count) if (what_row-dist+i >= 0) && (start_col+col_count >=0 && start_col+col_count <= image_col_len-1)
				do_blur_to_image(what_row+dist-i, start_col+col_count) if (what_row+dist-i <= (image_row_len-1)) && (start_col+col_count >=0 && start_col+col_count <= image_col_len-1)
				col_count += 1
			end
			i += 1
		end
	end


	def do_blur_to_image(what_row, what_col)
		image_holder[what_row][what_col] = 1 if image_holder[what_row][what_col] == 0
	end
end

blur_count =0
8.times do
	# cases for challenge
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
	puts "Test One pixel... in center"
	image_one_pixel.output_image
	image_one_pixel.blur(blur_count)
	puts "One pixel transformed...by " + blur_count.to_s + " pixels"
	image_one_pixel.output_image
	puts ""
	blur_count += 1
end

