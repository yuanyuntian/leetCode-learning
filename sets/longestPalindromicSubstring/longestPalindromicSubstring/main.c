//
//  main.c
//  longestPalindromicSubstring
//
//  Created by Fei Yuan on 2022/6/20.
//

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>
//<<<<<<<<<<<<<<<<<<<<<暴利求解<<<<<<<<<<<<<<<<<<<<<<<<<<<<<//
//反转 S，使之变成 S’。找到 S 和 S’之间最长的公共子串，这也必然是最长的回文子串。
//理由：如果找两个字符串的公共子串，i指向第一个字符串，j指向第二个字符串，用暴力求解法肯定就是i每走一步，j就不断的从头遍历第二个字符串，然后判断是否相等。
//j从前往后走，就相当于原字符串从后向前走。
//S=“abacdfgdcaba” , S ′ =“abacdgfdcaba”：S 以及 S’ 之间的最长公共子串为 “abacd”，显然，这不是回文。所以我们要加一个判断条件就可以了。
//————————————————


int IfPlalindrome(char *s) {
    int count = strlen(s);
    int left = 0;
    int right = count - 1;
    
    while (left < right) {
        if (s[left] != s[right]) {
            return 0;
        }
        left ++;
        right --;
    }
    return 1;
}


//反转字符串
char * reverse(char * s, int count) {
    char * p = (char *)malloc(sizeof(char) * (count + 1));
    int  i = 0;
    for (;i < count; i++) {
        p[i] = s[count - i - 1];
    }
    p[i] = '\0';
    return p;
}

char * longestPalindrome(char * s) {
    int count = strlen(s);
    //arr中存放最长的回文子串
    char * arr = (char *)malloc(sizeof(char) * 1001);
    char * p = reverse(s, count);
    unsigned int max = 0;
    //arr1存放每次一次循环遇见的回文子串
    char arr1[2000];
    for (int i = 0; i < count ; i ++) {
        for (int j = 0 ; j < count; j ++) {
            int m = i;
            int n = j;
            int k = 0;
            while (s[m] == p[n]) {
                arr1[k] = s[m];
                k ++;
                n ++;
                m ++;
            }
            arr1[k] = '\0';
            if (IfPlalindrome(arr1)) {
                //和arr中的回文子串长度作对比，大的话，就更新
                if (strlen(arr1) > max) {
                    max = strlen(arr1);
                    strcpy(arr, arr1);
                }
            }
        }
    }
    return arr;
}
//>>>>>>>>>>>>>>>>>>>>>动态规划>>>>>>>>>>>>>>>>>>>>>//
/* 动态规划就是要尽量避免重复的操作,s的长度为N，生成一个N*N的二维数组dp[1001][1001]
    dp[i][j]表示从s[i]到s[j]是否是回文
    dp[i][i] = true
 
 */
//<<<<<<<<<<<<<<<<<<<<<动态规划<<<<<<<<<<<<<<<<<<<<<<<<<<<<<//

//>>>>>>>>>>>>>>>>>>>>>中心扩展法>>>>>>>>>>>>>>>>>>>>>//
/* 以某个元素为中心，分别计算偶数的长度回文最大长度和奇数长度的回文的最大长度
 */

char * longestPalindrome2(char * s) {
    int len = strlen(s);
    int maxSubStrStart = 0;
    int maxSubStrLen = 0;

    //i表示中间元素下标
    for (int i = 1; i < len; i++) {
        int left = i - 1;
        int right = i + 1;
        int currentSubstrLen = 1;
        
        while (left >= 0 && s[left] == s[i]) {
            left --;
            currentSubstrLen++;
        }

        while (right < len  && s[right] == s[i]) {
            right ++;
            currentSubstrLen++;
        }
        
        while (left >= 0 && right < len && s[left] == s[right]) {
            left --;
            right ++;
            currentSubstrLen += 2;
        }
        
        if (currentSubstrLen > maxSubStrLen) {
            maxSubStrLen = currentSubstrLen;
            maxSubStrStart = left + 1;
        }
        
    }
    char * arr = (char *)malloc(sizeof(int) * (maxSubStrLen * 2));
    int i = 0;
    for (; i< maxSubStrLen; i++) {
        arr[i] = s[maxSubStrStart++];
    }
    arr[i] = '\0';
    return arr;
}

//我们也可以不使用子函数，直接在一个函数中搞定，我们还是要定义两个变量 start 和 maxLen，分别表示最长回文子串的起点跟长度，在遍历s中的字符的时候，我们首先判断剩余的字符数是否小于等于 maxLen 的一半，是的话表明就算从当前到末尾到子串是半个回文串，那么整个回文串长度最多也就是 maxLen，既然 maxLen 无法再变长了，计算这些就没有意义，直接在当前位置 break 掉就行了。否则就要继续判断，我们用两个变量 left 和 right 分别指向当前位置，然后我们先要做的是向右遍历跳过重复项，这个操作很必要，比如对于 noon，i在第一个o的位置，如果我们以o为最中心往两边扩散，是无法得到长度为4的回文串的，只有先跳过重复，此时left指向第一个o，right指向第二个o，然后再向两边扩散。而对于 bob，i在第一个o的位置时，无法向右跳过重复，此时 left 和 right 同时指向o，再向两边扩散也是正确的，所以可以同时处理奇数和偶数的回文串，之后的操作就是更新 maxLen 和 start 了，跟上面的操作一样，参见代码如下：

char * longestPalindrome3(char * s) {
    int len = strlen(s);
    if(len <= 1){
        return s;
    }
    int start = 0;
    int maxlen = 0;
    for (int i = 0; i < len;) {
        if (len - i < maxlen/2) {
            break;
        }
        int left = i;
        int right = i;
        while (right < len - 1 && s[right + 1] == s[right]) {
            ++right;
        }
        i = right + 1;
        while (right < len  - 1 && left > 0 && s[right + 1] == s[left - 1]) {
            ++right;
            --left;
        }
        if (maxlen < right - left + 1) {
            maxlen = right - left + 1;
            start = left;
        }
    }
    char * arr = (char *)malloc(sizeof(int) * (maxlen * 2));
    int i = 0;
    for (; i< maxlen; i++) {
        arr[i] = s[start++];
    }
    arr[i] = '\0';
    return arr;

}

//<<<<<<<<<<<<<<<<<<<<<中心扩展法<<<<<<<<<<<<<<<<<<<<<<<<<<<<<//
int main(int argc, const char * argv[]) {
    // insert code here...
    char * s = "abcbefgfeicba";
    char * p = longestPalindrome2(s);
    printf("%s\n",p);
    return 0;
}
