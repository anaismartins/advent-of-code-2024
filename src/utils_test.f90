program utils_test
   use utils
   implicit none

   integer :: i

   type(IntArray), allocatable :: data(:)

   data = read_file('./../input/day1.txt', '   ')
   print *, 'Data read from file with size:', size(data)

   do i = 1, size(data)
      print *, data(i)%values
   end do

   data = read_file('./../input/day2.txt', ' ')
   print *, 'Data read from file with size:', size(data)

   do i = 1, size(data)
      print *, data(i)%values
   end do
end program utils_test
