# A function that implements the quicksort algorithm.
# Running time complexity:  amortised O(nlogn), worst case: O(n^2)
# Running space complexity: O(nlogn), worst case: O(n)
#
# quicksort(int arr[], int start, int end)
# Requires: 'start' >= 0
#           'end' < length(arr)

# MAIN
addi x2, x2, 1000
# Store array values in contiguous memory at mem address 0x0:
# {10, 80, 30, 90, 40, 50, 70}
 addi x10, x0, 0

 addi x5, x0, 10
 sw x5, 0(x10) 
 addi x5, x0, 80
 sw x5, 4(x10)
 addi x5, x0, 30
 sw x5, 8(x10)
 addi x5, x0, 90
 sw x5, 12(x10)
 addi x5, x0, 40
 sw x5, 16(x10)
 addi x5, x0, 50
 sw x5, 20(x10)
 addi x5, x0, 70
 sw x5, 24(x10)

addi x11, x0, 0 # start
addi x12, x0, 6 # end

jal x1, QUICKSORT
jal x1, EXIT

QUICKSORT:
addi x2, x2, -20
sw x1, 16(x2)
sw x19, 12(x2)
sw x18, 8(x2)
sw x9, 4(x2)
sw x8, 0(x2)

addi x8, x10, 0
addi x9, x11, 0
addi x18, x12, 0
blt x12, x11, START_GT_END

jal x1, PARTITION

addi x19, x10, 0   # pi

addi x10, x8, 0
addi x11, x9, 0
addi x12, x19, -1
jal x1, QUICKSORT  # quicksort(arr, start, pi - 1);

addi x10, x8, 0
addi x11, x19, 1
addi x12, x18, 0
jal x1, QUICKSORT  # quicksort(arr, pi + 1, end);

START_GT_END:

lw x8, 0(x2)
lw x9, 4(x2)
lw x18, 8(x2)
lw x19, 12(x2)
lw x1, 16(x2)
addi x2, x2, 20
jalr x0, x1, 0

PARTITION:
addi x2, x2, -4
sw x1, 0(x2)

slli x5, x12, 2   # end * sizeof(int)
add x5, x5, x10  
lw x5, 0(x5)     # pivot = arr[end]
addi x6, x11, -1  # i = (start - 1)

addi x7, x11, 0   # j = start
LOOP:
beq x7, x12, LOOP_DONE   # while (j < end)

slli x28, x7, 2   # j * sizeof(int)
add x16, x28, x10   # (arr + j)
lw x28, 0(x16)     # arr[j]

addi x5, x5, 1   # pivot + 1
blt x5, x28, CURR_ELEMENT_GTE_PIVOT  # if (pivot <= arr[j])
addi x6, x6, 1   # i++

slli x30, x6, 2   # i * sizeof(int)
add x17, x30, x10   # (arr + i)
lw x30, 0(x17)     # arr[i]

sw x30, 0(x16)
sw x28, 0(x17)     # swap(&arr[i], &arr[j])

CURR_ELEMENT_GTE_PIVOT:
addi x7, x7, 1   # j++
beq x0, x0, LOOP
LOOP_DONE:

addi x30, x6, 1   # i + 1
addi x15, x30, 0   # Save for return value.
slli x30, x30, 2   # (i + 1) * sizeof(int)
add x17, x30, x10   # (arr + (i + 1))
lw x30, 0(x17)     # arr[i + 1]

slli x28, x12, 2   # end * sizeof(int)
add x16, x28, x10   # (arr + end)
lw x28, 0(x16)     # arr[end]

sw x30, 0(x16)
sw x28, 0(x17)     # swap(&arr[i + 1], &arr[end])

addi x10, x15, 0   # return i + 1

lw x1, 0(x2)
addi x2, x2, 4
jalr x0, x1, 0

EXIT:
addi x1, x0, 0
lw x10, 0(x1)
lw x11, 4(x1)
lw x12, 8(x1)
lw x13, 12(x1)
lw x14, 16(x1)
lw x15, 20(x1)
lw x16, 24(x1)