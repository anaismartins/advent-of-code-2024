module utils
   implicit none

   type :: IntArray
      integer, allocatable :: values(:)
   end type IntArray

contains

   function read_file(filename, separator) result(out_array)
      implicit none

      character(len=*), intent(in) :: filename
      integer :: unit_number, i, ios, nlines, temp_int, j, nvalues
      character(len=256) :: line, temp_line
      type(IntArray), allocatable :: out_array(:)
      character(len=*), intent(in) :: separator

      ! dimension out_array(nrows, ncols)
      unit_number = 10

      open(unit=unit_number, file=filename, status='old', action='read')

      ! count lines
      nlines = 0
      do
         read(unit_number, '(A)', iostat=ios)
         nlines = nlines + 1
         if (ios /= 0) exit
      end do

      print *, 'Number of lines in file:', nlines

      ! go back to beginning to file
      rewind(unit_number)

      ! allocate number of lines for array
      allocate(out_array(nlines))

      do i = 1, nlines
         read(unit_number, '(A)', iostat=ios) line ! (A) reads a string
         if (ios == 0) then
            ! print *, 'Reading line:', i, 'Content:', trim(line)

            temp_line = line
            nvalues = 0

            do
               read(temp_line, *, iostat=ios) temp_int
               if (ios /= 0) exit
               nvalues = nvalues + 1

               j = index(temp_line, separator)
               if (j>0) then
                  temp_line = temp_line(j+1:)
               else
                  exit
               end if
            end do

            ! print *, 'Number of values in line', i, ':', nvalues

            allocate(out_array(i)%values(nvalues))

            read(line, *, iostat=ios) (out_array(i)%values(j), j=1, nvalues)
         else
            exit
         end if
      end do

      close(unit_number)
   end function read_file

end module utils
