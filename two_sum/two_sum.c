/*
Note: The returned array must be malloced, assume caller calls free().
 */
#include <stdio.h>
#include <stdlib.h>

int* twoSum(int* nums, int numsSize, int target, int* returnSize){
  int* solution = (int *)calloc(sizeof(int) * *returnSize, sizeof(int) * *returnSize);
  int i, j, diff;
  for (i = 0; i < numsSize; i++) {
    diff = target - nums[i];
    for (j = i; j < numsSize; j++) {
      if (diff == nums[j]) {
        solution[0] = i;
        solution[1] = j;
        break;
      }
    }
  }
  return solution;
}

int main(int argc, char* argv[]) {
  int nums[] = {2, 7, 11, 15};
  int numsSize = 4;
  int target = 9;
  int returnSize = 2;

}

