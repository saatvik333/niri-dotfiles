return {
  {
    name = "cpp-templates",
    dir = vim.fn.stdpath("config"),
    event = "BufNewFile",
    cmd = { "CppTemplate", "CppCompetitive", "CppSimple" },
    keys = {
      { "<leader>ct", "<cmd>CppTemplate<cr>", desc = "C++ Templates" },
      { "<leader>ccp", "<cmd>CppCompetitive<cr>", desc = "C++ Competitive Programming Template" },
      { "<leader>cS", "<cmd>CppSimple<cr>", desc = "C++ Simple Main Template" },
    },
    config = function()
      local templates = {
        {
          name = "Competitive Programming",
          description = "Full competitive programming template with fast I/O",
          content = [[#include <bits/stdc++.h>
using namespace std;

typedef long long ll;
typedef long double ld;
#define endl '\n'

void solve() {

}

int main() {
  // Fast IO
  ios::sync_with_stdio(0);
  cin.tie(NULL);
  cout.tie(NULL);

  ll T;
  cin >> T;
  while (T--) {
    solve();
  }

  return 0;
}]],
        },
        {
          name = "Simple Main",
          description = "Basic C++ template with main function",
          content = [[#include <bits/stdc++.h>
using namespace std;

int main() {

  return 0;
}]],
        },
        {
          name = "Basic Template",
          description = "Minimal C++ template with common headers",
          content = [[#include <iostream>
#include <vector>
#include <string>
using namespace std;

int main() {

  return 0;
}]],
        },
        {
          name = "Algorithm Practice",
          description = "Template for algorithm practice with common includes",
          content = [[#include <iostream>
#include <vector>
#include <algorithm>
#include <string>
#include <map>
#include <set>
#include <queue>
#include <stack>
using namespace std;

int main() {

  return 0;
}]],
        },
        {
          name = "Class Template",
          description = "Template with a basic class structure",
          content = [[#include <iostream>
using namespace std;

class Solution {
public:

};

int main() {
  Solution sol;

  return 0;
}]],
        },
      }

      local function apply_template(template)
        local buf = vim.api.nvim_get_current_buf()
        local lines = vim.split(template.content, "\n")
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

        for i, line in ipairs(lines) do
          if line:match("^%s*$") and i > 1 then
            vim.api.nvim_win_set_cursor(0, { i, vim.fn.indent(i) })
            break
          end
        end

        vim.notify("Applied template: " .. template.name)
      end

      local function select_template()
        vim.ui.select(templates, {
          prompt = "Select C++ Template:",
          format_item = function(item)
            return item.name .. " - " .. item.description
          end,
        }, function(item)
          if item then
            apply_template(item)
          end
        end)
      end

      local function maybe_prompt_cpp_template()
        if vim.tbl_isempty(vim.api.nvim_list_uis()) then
          return
        end

        local bufname = vim.api.nvim_buf_get_name(0)
        if not bufname:match("%.cpp$") then
          return
        end

        local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
        if not (#lines == 1 and lines[1] == "") then
          return
        end

        vim.defer_fn(function()
          local choice = vim.fn.confirm("Use C++ template?", "&Yes\n&No\n&Select", 1)
          if choice == 1 then
            apply_template(templates[1])
          elseif choice == 3 then
            select_template()
          end
        end, 100)
      end

      vim.api.nvim_create_autocmd("BufNewFile", {
        pattern = "*.cpp",
        callback = maybe_prompt_cpp_template,
      })

      vim.api.nvim_create_user_command("CppTemplate", function()
        select_template()
      end, { desc = "Select C++ template" })

      vim.api.nvim_create_user_command("CppCompetitive", function()
        apply_template(templates[1])
      end, { desc = "Apply competitive programming template" })

      vim.api.nvim_create_user_command("CppSimple", function()
        apply_template(templates[2])
      end, { desc = "Apply simple main template" })
    end,
  },
}
