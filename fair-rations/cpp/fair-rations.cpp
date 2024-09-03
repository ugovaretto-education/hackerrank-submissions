#include <algorithm>
#include <fstream>
#include <iostream>
#include <iterator>
// as of August 2024 Hackerrank does not support C++20
// resorting to old-style begin/end :-(
// #include <ranges>
#include <string>
#include <vector>

using namespace std;

string ltrim(const string &);
string rtrim(const string &);
vector<string> split(const string &);

template <typename A, typename FwdIt, typename F, typename Ret = A>
Ret fold(F f, A acc, FwdIt b, FwdIt e) {
  return b == e ? acc : fold(f, f(acc, *b++), b, e);
}

template <typename T> ostream &print_array(const vector<T> &v, ostream &os) {
  copy(begin(v), end(v), ostream_iterator<T>(std::cout, " "));
  return os;
}

constexpr bool even(int x) { return x % 2 == 0; }
constexpr bool odd(int x) { return !even(x); }

bool is_even(const vector<int> &v) {
  return fold([](bool acc, bool v) { return acc && even(v); }, true, begin(v),
              end(v));
  return true;
}

template <typename T> class Maybe {
private:
  T val;
  bool none;

public:
  Maybe() : none(true) {}
  Maybe(const T &v) : val(v), none(false) {}
  bool operator==(const Maybe &other) const {
    return none ? other.none : other.val == val;
  }
  bool operator!=(const Maybe &other) const { return !this->operator==(other); }
  bool operator!() const { return none; }
  template <typename U> friend const U &Get(const Maybe<U> &);
  template <typename F>
  friend Maybe<T> Compose(F, const Maybe<T> &, const Maybe<T> &);
};
template <typename T> Maybe<T> Just(const T &v) { return Maybe<T>{v}; }
template <typename T> Maybe<T> None() { return Maybe<T>{}; }
template <typename T> const T &Get(const Maybe<T> &m) {
  // panic/unwrap equivalent, impossible to recover
  if (!m) {
    cerr << "Empty Maybe value" << endl;
    exit(EXIT_FAILURE);
  }
  return m.val;
}

template <typename F, typename T, typename U>
Maybe<T> Apply(const Maybe<T> &m1, const Maybe<U> &m2, F f) {
  if (!m1 || !m2)
    return None<T>();
  return Just(f(Get<T>(m1), Get<U>(m2)));
}

template <typename T> Maybe<T> Sum(const Maybe<T> &m1, const Maybe<T> &m2) {
  return Apply(m1, m2, [](const T &x, const T &y) { return x + y; });
}

template <typename F, typename H, typename... T>
Maybe<H> MApply(F f, const Maybe<H> &h, const Maybe<T> &...t) {
  return Apply(h, MApply(f, t...), f);
}

template <typename F, typename H, typename T>
Maybe<H> MApply(F f, const Maybe<H> &h, const Maybe<T> &t) {
  return Apply(h, t, f);
}

// works with non random iterators and with any aritmetic type
template <typename BiDirIteratorT>
auto fairRations(BiDirIteratorT b, BiDirIteratorT e) {
  if (b == e)
    return Just(0);
  if (b == --e) {
    if (odd(*b))
      return None<int>();
    else
      return Just(0);
  }
  ++e;
  auto i = find_if(b, e, odd);
  if (i == e)
    return Just(0);
  ++*i;
  auto sum = [](auto x, auto y) { return x + y; };
  if (++i == e) {
    --i;
    *--i += 1;
    ++i;
    return MApply(sum, Just(2), fairRations(b, i));
  } else {
    // already advanced to next element in prev if statement
    *i += 1;
    return MApply(sum, Just(2), fairRations(i, e));
  }
}

int fairRationsDumb(vector<int> v) {
  int b = 0;
  int e = v.size();
  int cnt = 0;
  while (true) {
    while (b != e && !odd(v[b]))
      ++b;
    if (b == e)
      return cnt;
    ++v[b];
    if (b == e - 1) {
      if (odd(v[b])) {
        cnt = -1;
        break;
      }
      ++v[b - 1];
      e = b;
      b = 0;
      cnt += 2;
    } else {
      ++v[b + 1];
      cnt += 2;
    }
  }
  return cnt;
}

int main() {
  std::streambuf *buf = nullptr;
  std::ofstream of;
  const char *path = getenv("OUTPUT_PATH");
  if (path) {
    of.open(path);
    buf = of.rdbuf();
  } else {
    buf = std::cout.rdbuf();
  }

  ostream fout(buf);

  string N_temp;
  getline(cin, N_temp);

  string B_temp_temp;
  getline(cin, B_temp_temp);

  vector<string> B_temp = split(rtrim(B_temp_temp));

  const auto N = B_temp.size();
  vector<int> B(N);

  for (int i = 0; i < N; i++) {
    int B_item = stoi(B_temp[i]);
    B[i] = B_item;
  }
  string result = [&B]() {
    if (B.size() < 2)
      return string("NO");
    if (is_even(B))
      return string("0");
#ifdef DUMB
    const int r = fairRationsDumb(B);
    return r < 0 ? "NO" : to_string(r);
#else
    const auto r = fairRations(begin(B), end(B));
    return !r ? string("NO") : to_string(Get(r));
#endif
  }();

  fout << result << "\n";

  return 0;
}

string ltrim(const string &str) {
  string s(str);
  s.erase(begin(s),
          find_if(begin(s), end(s), [](char x) { return !isspace(x); }));
  return s;
}

string rtrim(const string &str) {
  string s(str);

  s.erase(
      find_if(rbegin(s), rend(s), [](char x) { return !isspace(x); }).base(),
      end(s));
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
