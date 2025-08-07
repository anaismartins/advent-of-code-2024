program day2
   use utils
   implicit none

   type(IntArray), allocatable :: data(:)
   integer :: i, j, nsafe, diff, temp
   logical :: safe

   data = read_file('/mn/stornext/u3/aimartin/d5/advent-of-code-2024/input/day2.txt', ' ')

   nsafe = 0
   temp = 0
   safe = .true.
   do i = 1, size(data)
      do j = 2, size(data(i)%values)
         diff = data(i)%values(j) - data(i)%values(j-1)
         if (abs(diff) > 3 .or. diff == 0) then
            safe = .false.
            print *, 'Unsafe report (condition 1) at line', i, 'column', j, ':', data(i)%values(j-1), '->', data(i)%values(j)
            exit
         end if

         if ((temp > 0 .and. diff < 0) .or. (temp < 0 .and. diff > 0)) then
            safe = .false.
            print *, 'Unsafe report (condition 2) at line', i, 'column', j, ':', temp, '->', diff
            print *, 'Values in line:', data(i)%values
            exit
         end if

         temp = diff
      end do
      if (safe) nsafe = nsafe + 1

      safe = .true.
      temp = 0
   end do
   print *, 'Number of safe reports:', nsafe
end program day2
