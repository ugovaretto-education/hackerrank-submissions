#include <algorithm>
#include <fstream>
#include <iostream>
#include <iterator>
#include <ranges>
#include <string>
#include <vector>

using namespace std;

string ltrim(const string &);
string rtrim(const string &);
vector<string> split(const string &);

/*
 * Complete the 'fairRations' function below.
 *
 * The function is expected to return a STRING.
 * The function accepts INTEGER_ARRAY B as parameter.
 */

template <typename A, typename FwdIt, typename F, typename Ret = A>
Ret fold(F f, A acc, FwdIt b, FwdIt e) {
  return b == e ? acc : fold(f, f(acc, *b), b++, e);
}

template <typename T> ostream &print_array(const vector<T> &v, ostream &os) {
  copy(begin(v), end(v), ostream_iterator<T>(std::cout, " "));
  return os;
}

constexpr bool even(int x) { return x % 2 == 0; }
constexpr bool odd(int x) { return !even(x); }

bool is_even(const vector<int> &v) {
  const bool ret = fold([](bool acc, bool v) { return acc && even(v); }, true,
                        begin(v), end(v));
  return ret;
}
int fairRations(vector<int> &&B) {
  if (B.size() < 2) {
    return -1;
  }
  auto i = ranges::find_if(B, odd);
  if (i == end(B))
    return 0;

  *i += 1;
  auto l = i;
  auto r = i;
  l = i != begin(B) ? --l : i;
  r = r != --end(B) ? ++r : i;
  if (r != i && odd(*r))
    *r += 1;
  else if (l != i && odd(*l))
    *l += 1;
  else if (r != i)
    *r += 1;
  else if (l != i)
    *l += 1;

  i = begin(B);
  auto adjacentOdds = false;
  while (i != end(B)) {
    if (i != --end(B)) {
      if (odd(*i) && odd(*++i)) {
        adjacentOdds = true;
        break;
      }
    }
    ++i;
  }
  if (!adjacentOdds && ranges::find_if(B, odd) != end(B)) {
    return -1;
  }
  return 2 + fairRations(std::move(B));
}

int main() {
  ofstream fout(getenv("OUTPUT_PATH"));

  string N_temp;
  getline(cin, N_temp);

  int N = stoi(ltrim(rtrim(N_temp)));

  string B_temp_temp;
  getline(cin, B_temp_temp);

  vector<string> B_temp = split(rtrim(B_temp_temp));

  vector<int> B(N);

  for (int i = 0; i < N; i++) {
    int B_item = stoi(B_temp[i]);

    B[i] = B_item;
  }

  const auto r = fairRations(std::move(B));
  string result = r >= 0 ? to_string(r) : "NO";

  fout << result << "\n";

  fout.close(); // ????

  return 0;
}

string ltrim(const string &str) {
  string s(str);
  s.erase(begin(s),
          find_if(begin(s), end(s), [](char x) { return !isspace(x); }));
  // s.erase(s.begin(),
  //         find_if(s.begin(), s.end(), not1(ptr_fun<int, int>(isspace))));

  return s;
}

string rtrim(const string &str) {
  string s(str);

  s.erase(
      find_if(rbegin(s), rend(s), [](char x) { return !isspace(x); }).base(),
      end(s));
  // s.erase(
  //     find_if(s.rbegin(), s.rend(), not1(ptr_fun<int,
  //     int>(isspace))).base(), s.end());
  //
  return s;
}

vector<string> split(const string &str) {
  vector<string> tokens;

  string::size_type start = 0;
  string::size_type end = 0;

  while ((end = str.find(" ", start)) != string::npos) {
    tokens.push_back(str.substr(start, end - start));

    start = end + 1;
  }

  tokens.push_back(str.substr(start));

  return tokens;
}
// int m() {
//
//   std::vector<int> v{1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
//   // Filter takes a predicate function for evaluation
//   auto even_numbers =
//       v | ranges::views::filter([](int x) { return x % 2 == 0; });
//
//   for (int n : even_numbers) {
//     std::cout << n << " ";
//   }
//   std::cout << std::endl; // Output: 2 4 6 8 10
//   return 0;
// }
