import java.util.*;
import java.io.*;

public class StringPermutation {
  private boolean isPermutation(char[] string1, char[] string2) {
    if (string1.length != string2.length) {
      return false;
    }

    if (string1.length == 1 && string2.length == 1) {
      if (string1[0] == string2[0]) {
        return true;
      } else {
        return false;
      }
    }

    char[] copyString2 = new char[string2.length];
    int i = 0;
    int k = 0;
    boolean found = false;
    for (i = 0; i < string2.length; i++) {
      if (string1[0] == string2[i]) {
        found = true;
      } else {
        copyString2[k] = string2[i];
        k++;
      }
    }

    if (found) {
      return isPermutation(Arrays.copyOfRange(string1, 1, string1.length), Arrays.copyOfRange(copyString2, 0, copyString2.length - 1));
    } else {
      return false;
    }
  }

  public static void main(String[] args) {
    StringPermutation checker = new StringPermutation();
    if(checker.isPermutation("This".toCharArray(), "sihT".toCharArray())) {
      System.out.println("PASSED: Permutation on 'This'"); 
    } else {
      System.out.println("FAILED on 'This'"); 
    }

    if(checker.isPermutation("aaaaa".toCharArray(), "bbbbb".toCharArray())) {
      System.out.println("FAILED: Permutation on 'aaaaaaa'"); 
    } else {
      System.out.println("PASSED on 'aaaaa'"); 
    }

    if(checker.isPermutation("abcdefg".toCharArray(), "gfedcba".toCharArray())) {
      System.out.println("PASSED: Permutation on 'abdcefg'"); 
    } else {
      System.out.println("FAILED on 'abcdefg'"); 
    }

  }
}
