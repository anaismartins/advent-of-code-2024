module quicksort_mod
contains

   recursive subroutine quicksort(array)
      implicit none
      integer, intent(inout) :: array(:)
      integer :: pivot, left, right, temp

      if (size(array) > 1) then
         pivot = array(size(array) / 2)
         left = 1
         right = size(array)

         do while (left <= right)
            do while (array(left) < pivot)
               left = left + 1
               if (left > size(array)) exit
            end do
            do while (array(right) > pivot)
               right = right - 1
               if (right < 1) exit
            end do
            if (left <= right) then
               temp = array(left)
               array(left) = array(right)
               array(right) = temp
               left = left + 1
               right = right - 1
            end if
         end do
         if (right >=1) then
            call quicksort(array(1:right))
         end if
         if (left <= size(array)) then
            call quicksort(array(left:size(array)))
         end if
      end if

   end subroutine quicksort

end module quicksort_mod


program day1
   use quicksort_mod
   implicit none

   integer, parameter :: max_lines = 1000
   integer, parameter :: unit_number = 1

   integer :: leftlist(max_lines), rightlist(max_lines)
   integer :: i, j, ios, sum
   logical :: eof
   integer :: similarity_score, target_number

   ! read the input
   open(UNIT=unit_number, FILE='./../input/day1.txt', STATUS='OLD', ACTION='READ') ! UNIT assigns a unique integer to the file for subsequent operations

   i = 0
   eof = .false.
   do while (.not. eof)
      i = i + 1
      read(unit_number, *, iostat=ios) leftlist(i), rightlist(i)
      if (ios == -1) then
         eof = .true.
         i = i - 1  ! Adjust index to fit the actual number of read items
      end if
   end do

   ! Close the file
   close(unit_number)

   call quicksort(leftlist(1:i))
   call quicksort(rightlist(1:i))

   do j = 1, i
      sum = sum + abs(leftlist(j) - rightlist(j))
   end do

   print*, 'The sum of the absolute differences is:', sum

   ! 2nd part
   similarity_score = 0

   do j = 1, i
      target_number = leftlist(j)
      similarity_score = similarity_score + target_number * count(rightlist(1:i) == target_number)
   end do
   print*, 'The similarity score is:', similarity_score

end program
