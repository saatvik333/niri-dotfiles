return {
  {
    name = "cpp-snippets",
    dir = vim.fn.stdpath("config"),
    ft = { "cpp" },
    dependencies = {
      "L3MON4D3/LuaSnip",
    },
    config = function()
      local ls = require("luasnip")
      local s = ls.snippet
      local t = ls.text_node
      local i = ls.insert_node

      ls.add_snippets("cpp", {
        s("cptemp", {
          t({
            "#include <bits/stdc++.h>",
            "using namespace std;",
            "",
            "typedef long long ll;",
            "typedef long double ld;",
            "#define endl '\\n'",
            "",
            "void solve() {",
            "  ",
          }),
          i(1),
          t({
            "",
            "}",
            "",
            "int main() {",
            "  // Fast IO",
            "  ios::sync_with_stdio(0);",
            "  cin.tie(NULL);",
            "  cout.tie(NULL);",
            "  ",
            "  ll T;",
            "  cin >> T;",
            "  while (T--) {",
            "    solve();",
            "  }",
            "  ",
            "  return 0;",
            "}",
          }),
        }),

        s("mainsimple", {
          t({
            "#include <bits/stdc++.h>",
            "using namespace std;",
            "",
            "int main() {",
            "  ",
          }),
          i(1),
          t({
            "",
            "  return 0;",
            "}",
          }),
        }),

        s("cppbasic", {
          t({
            "#include <iostream>",
            "#include <vector>",
            "#include <string>",
            "using namespace std;",
            "",
            "int main() {",
            "  ",
          }),
          i(1),
          t({
            "",
            "  return 0;",
            "}",
          }),
        }),

        s("algotemplate", {
          t({
            "#include <iostream>",
            "#include <vector>",
            "#include <algorithm>",
            "#include <string>",
            "#include <map>",
            "#include <set>",
            "#include <queue>",
            "#include <stack>",
            "using namespace std;",
            "",
            "int main() {",
            "  ",
          }),
          i(1),
          t({
            "",
            "  return 0;",
            "}",
          }),
        }),

        s("classtemplate", {
          t({
            "#include <iostream>",
            "using namespace std;",
            "",
            "class Solution {",
            "public:",
            "  ",
          }),
          i(1),
          t({
            "",
            "};",
            "",
            "int main() {",
            "  Solution sol;",
            "  ",
          }),
          i(2),
          t({
            "",
            "  return 0;",
            "}",
          }),
        }),
      })
    end,
  },
}
