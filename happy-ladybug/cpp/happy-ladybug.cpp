#include <algorithm>
#include <cctype>
#include <fstream>
#include <iostream>
#include <string>
#include <unordered_map>
#include <vector>
using namespace std;

string ltrim(const string &);
string rtrim(const string &);

/*
 * Complete the 'happyLadybugs' function below.
 *
 * The function is expected to return a STRING.
 * The function accepts STRING b as parameter.
 */

using Idx = string::difference_type;


bool Paired(string s) {
  for(auto i = 1; i != s.size()-1; ++i) {
    if(s[i] != '_' && s[i] != s[i -1] && s[i] != s[i+1]) return false;
  }
  if(s.size() > 1 && s[0] != '_' && s[1] != s[0]) return false;
  if(s.size() > 1 && s[s.size() - 1] != '_' && s[s.size() - 1] != s[s.size() - 2])
    return false;
  return true;
}

bool Single(string s) {
  unordered_map<char, int> m;
  for(auto c: s) {
    if(c == '_') continue;
    ++m[c];
  }
  for(auto i: m){
    if(i.second == 1) return true;
  }
  return false;
}


string happyLadybugs(string b) {
  if(Paired(b)) return "YES";
  if(b.find('_') != string::npos && !Single(b)) return "YES";
  return "NO";
}

int main() {
  ofstream fout(getenv("OUTPUT_PATH"));

  string g_temp;
  getline(cin, g_temp);

  int g = stoi(ltrim(rtrim(g_temp)));

  for (int g_itr = 0; g_itr < g; g_itr++) {
    string n_temp;
    getline(cin, n_temp);

    int n = stoi(ltrim(rtrim(n_temp)));

    string b;
    getline(cin, b);

    string result = happyLadybugs(b);

    //change to fout when submitting
    cout << result << "\n";
  }

  fout.close();

  return 0;
}

string ltrim(const string &str) {
  string s(str);

  s.erase(s.begin(),
          find_if(s.begin(), s.end(), [](auto c) { return !isspace(c); }));

  return s;
}

string rtrim(const string &str) {
  string s(str);

  s.erase(
      find_if(s.rbegin(), s.rend(), [](auto c) { return !isspace(c); }).base(),
      s.end());

  return s;
}
