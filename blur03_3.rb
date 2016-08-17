# blur 03 

class Image
	attr_accessor :my_image, :image_row_len, :image_col_len, :blur_pt_list, :curLocation

	def initialize(the_array)
		#stor the pic data (coming from the_array) and then get the size
		@my_image = the_array
		@image_row_len = the_array.length
		@image_col_len = the_array[0].length
		@blur_pt_list = []
	end

	def output_image
		#Grab each row with an each do
		my_image.each do |the_row|
			 puts the_row.join
		end
	end


	def get_blur_start_points
		blur_pt_list.clear

		#get a list of points to blur
		row_index = 0
		my_image.each do |row|
  			col_index = 0
  			row.each do |col_cell|
  				#check col_cell to see if its a 1 (for a row)
  				if col_cell == 1
	   				location = [row_index, col_index]
	   				blur_pt_list.concat [location]
  				end     
  				col_index += 1
  			end
  			row_index += 1
  		end
	end





	def do_blur_to_image(r, c)
		my_image[r][c] = 1 if (r >=0 && r < image_row_len) && (c >=0 && c < image_col_len) && my_image[r][c] == 0
	end

	def blur_cross(r, c, d)
		(0..d).each do |i|
			self.do_blur_to_image( r, c-i )
			self.do_blur_to_image( r, c+i )
			self.do_blur_to_image( r-i, c )
			self.do_blur_to_image( r+i, c )
		end
	end

	def manhattan_blur(row, col, dist)
		(0..dist).each do |i|
			self.blur_cross(row, col+i, dist-i) 
			self.blur_cross(row, col-i, dist-i) 
		end
	end

	def blur(distance)
		self.get_blur_start_points

		blur_pt_list.each do |the_loc|
			self.manhattan_blur(the_loc[0],the_loc[1], distance)
		end
	end

	
end

(0..9).each do |x|
	i = Image.new([
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


	puts "test of manhattan blur(#{x})"
	i.blur(x)
	i.output_image
	puts ""
end



	
