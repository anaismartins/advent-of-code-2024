module day2utils
   implicit none

contains

   logical function check_safe(report)
      integer, intent(in) :: report(:)
      integer :: i, diff, temp!, sign_val

      temp = 0
      check_safe = .true.
      do i = 2, size(report)
         diff = report(i) - report(i-1)
         ! sign_val = sign(diff, temp)
         if (abs(diff) > 3 .or. diff == 0 .or. (temp > 0 .and. diff < 0) .or. (temp < 0 .and. diff > 0))  then
            check_safe = .false.
            return
         else
            temp = diff
         end if

      end do
   end function check_safe

   logical function dampen(report)
      integer, intent(in) :: report(:)
      integer :: report2(size(report) - 1)
      integer :: i
      do i = 1, size(report)
         report2(1:i-1) = report(1:i-1)
         report2(i:size(report)-1) = report(i+1:size(report))
         if (check_safe(report2)) then
            dampen = .true.
            return
         end if
      end do
      dampen = .false.
   end function dampen

end module day2utils

program day2
   use utils
   use day2utils

   implicit none

   type(IntArray), allocatable :: data(:)
   integer :: i, num

   num = 0
   data = read_file('/mn/stornext/u3/aimartin/d5/advent-of-code-2024/input/day2.txt', ' ')

   do i = 1, size(data)
      if (check_safe(data(i)%values)) then
         num = num + 1
      end if
   end do
   print *, 'Number of safe reports:', num

   num = 0

   do i = 1, size(data)
      if (check_safe(data(i)%values)) then
         num = num + 1
      else
         if (dampen(data(i)%values)) then
            num = num + 1
         end if
      end if
   end do

   print *, 'Number of safe reports:', num

end program day2
