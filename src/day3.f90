program day3
   use forgex
   implicit none

   integer :: unit_number, ios, a, b, i, sum, j, k
   character(len=4000) :: filename, line
   character(:), allocatable :: pattern, res, res_cropped
   character(:), allocatable :: str

   unit_number = 10
   filename = '/mn/stornext/u3/aimartin/d5/advent-of-code-2024/input/day3.txt'
   open(unit=unit_number, file=filename, status='old', action='read')

   k = 0
   sum = 0
   do
      read(unit_number, '(A)', iostat=ios) line
      if (ios /= 0) exit
      k = k + 1
      print *, 'Reading line number', k

      pattern = 'mul\((-?\d+),(-?\d+)\)'
      do
         if (pattern .in. line) then
            res = regex_f(pattern, line)

            i = index(res, ',')
            read(res(5:i-1), *) a
            read(res(i+1:len_trim(res)-1), *) b

            sum = sum + a * b

            j = index(line, res)
            line = line(j+len(res):)
            if (len_trim(line) == 0) exit
         else
            exit
         end if
      end do

   end do

   print *, 'Total sum:', sum

end program day3
