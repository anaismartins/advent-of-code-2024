program day2
   use utils
   implicit none

   type(IntArray), allocatable :: data(:)
   integer :: i, j, nsafe, diff, temp

   data = read_file('/mn/stornext/u3/aimartin/d5/advent-of-code-2024/input/day2.txt', ' ')

   nsafe = 0
   temp = 0
   do i = 1, size(data)
      do j = 2, size(data(i)%values)
         diff = data(i)%values(j) - data(i)%values(j-1)
         if (diff > 3 .or. diff < -3 .or. diff == 0) exit
         if ((temp > 0 .and. diff < 0) .or. (temp < 0 .and. diff > 0)) exit
         temp = diff
      end do

   end do
end program day2
