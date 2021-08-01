using System;
using System.Collections.Generic;
using System.Linq;

namespace Tetst
{
  class Program
  {
    static void Main(string[] args)
    {
      string str = "dbcafe";
      Console.WriteLine(stringOrderBy(str.ToCharArray()));
    }
    static string removeDuplicateInString(Char[] chArray)
    {
      List<char> lstChar = new List<char>();
      int nums = chArray.Length;
      for (int index = 0; index < nums -1 ; index++)
        if (!lstChar.Contains(chArray[index]))
          lstChar.Add(chArray[index]);
      return concat(lstChar.ToArray());
    }
    static string binarySearch()
    {

    }
    static string stringOrderBy(char[] lstChar)
    {
      int index, pass, nums = lstChar.Length;
      char _ch;
      for (pass = 0; pass < nums - 1; pass++)
        for (index = pass + 1; index < nums; index++)
        {
          if (lstChar[index] < lstChar[pass])
          {
            _ch = lstChar[pass];
            lstChar[pass] = lstChar[index];
            lstChar[index] = _ch;
          }
        }
      return concat(lstChar);
    }
    static string concat(char[] lstChar)
    {
      string result = "";
      foreach (var item in lstChar)
      {
        result += item;
      }
      return result;
    }
  }
  //  static void Main(string[] args)
  //  {
  //    Console.WriteLine(removeDuplicateString("aabbddcc"));
  //    Console.WriteLine(removeDuplicateString("aabccdd"));
  //    Console.WriteLine(removeDuplicateString("xyz"));
  //    string abc = "aabbddcc";
  //    var lstChar = abc.ToCharArray().ToList().Distinct();
  //    string result = string.Concat(lstChar);
  //    Console.WriteLine(result);
  //    int[] arrOfInt1 = { 2, 4, 2 };
  //    int indexOfInt1First = 1;
  //    int indexOfInt1Second = 2;
  //    indexOfInt1First = int.Parse(Console.ReadLine());
  //    indexOfInt1Second = int.Parse(Console.ReadLine());
  //    Console.WriteLine("[" + indexOfInt1First + "," + indexOfInt1Second + "]," + "target =" + sum(arrOfInt1, indexOfInt1First, indexOfInt1Second));
  //    Console.WriteLine("Output:[" + indexOfInt1First + "," + indexOfInt1Second + "]");
  //  }

  //  static int sum(int[] arrOfInt, int firstIndex, int secondeIndex)
  //  {
  //    int result = 0;
  //    result = arrOfInt[firstIndex] + arrOfInt[secondeIndex];
  //    return result;
  //  }

  //  static string removeDuplicateString(string arr)
  //  {
  //    List<char> result = new List<char>();
  //    char[] lstChar = arr.ToCharArray();
  //    for (int i = 0; i < lstChar.Length; i++)
  //    {
  //      if (!result.Contains(lstChar[i]))
  //        result.Add(lstChar[i]);
  //    }
  //    return string.Concat(result);

  //  }
  //}
}
