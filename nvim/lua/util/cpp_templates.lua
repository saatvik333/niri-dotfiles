-- Shared C++ template data consumed by both cpp-snippets.lua (LuaSnip) and
-- cpp-templates.lua (BufNewFile picker). Each template is a sequence of
-- segments alternating between literal text and snippet insert placeholders.
local M = {}

M.list = {
  {
    name = "Competitive Programming",
    description = "Full competitive programming template with fast I/O",
    trigger = "cptemp",
    segments = {
      {
        kind = "text",
        lines = {
          "#include <bits/stdc++.h>",
          "using namespace std;",
          "",
          "typedef long long ll;",
          "typedef long double ld;",
          "#define endl '\\n'",
          "",
          "void solve() {",
          "  ",
        },
      },
      { kind = "insert", index = 1 },
      {
        kind = "text",
        lines = {
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
        },
      },
    },
  },
  {
    name = "Simple Main",
    description = "Basic C++ template with main function",
    trigger = "mainsimple",
    segments = {
      {
        kind = "text",
        lines = {
          "#include <bits/stdc++.h>",
          "using namespace std;",
          "",
          "int main() {",
          "  ",
        },
      },
      { kind = "insert", index = 1 },
      {
        kind = "text",
        lines = {
          "",
          "  return 0;",
          "}",
        },
      },
    },
  },
  {
    name = "Basic Template",
    description = "Minimal C++ template with common headers",
    trigger = "cppbasic",
    segments = {
      {
        kind = "text",
        lines = {
          "#include <iostream>",
          "#include <vector>",
          "#include <string>",
          "using namespace std;",
          "",
          "int main() {",
          "  ",
        },
      },
      { kind = "insert", index = 1 },
      {
        kind = "text",
        lines = {
          "",
          "  return 0;",
          "}",
        },
      },
    },
  },
  {
    name = "Algorithm Practice",
    description = "Template for algorithm practice with common includes",
    trigger = "algotemplate",
    segments = {
      {
        kind = "text",
        lines = {
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
        },
      },
      { kind = "insert", index = 1 },
      {
        kind = "text",
        lines = {
          "",
          "  return 0;",
          "}",
        },
      },
    },
  },
  {
    name = "Class Template",
    description = "Template with a basic class structure",
    trigger = "classtemplate",
    segments = {
      {
        kind = "text",
        lines = {
          "#include <iostream>",
          "using namespace std;",
          "",
          "class Solution {",
          "public:",
          "  ",
        },
      },
      { kind = "insert", index = 1 },
      {
        kind = "text",
        lines = {
          "",
          "};",
          "",
          "int main() {",
          "  Solution sol;",
          "  ",
        },
      },
      { kind = "insert", index = 2 },
      {
        kind = "text",
        lines = {
          "",
          "  return 0;",
          "}",
        },
      },
    },
  },
}

-- Flattens a template's segments into buffer lines (placeholders dropped — the
-- trailing whitespace in the preceding text segment marks where the user types).
function M.to_lines(template)
  local lines = {}
  for _, seg in ipairs(template.segments) do
    if seg.kind == "text" then
      for _, line in ipairs(seg.lines) do
        table.insert(lines, line)
      end
    end
  end
  return lines
end

return M
