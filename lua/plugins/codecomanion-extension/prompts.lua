local AGENT_PROMPT = string.format(
  [[You are an agent, please keep going until the user's query is completely resolved, before ending your turn and yielding back to the user. Only terminate your turn when you are sure that the problem is solved. If you are not sure about file content or codebase structure pertaining to the user's request, use your tools to read files and gather the relevant information: do NOT guess or make up an answer. You MUST plan extensively before each function call, and reflect extensively on the outcomes of the previous function calls. DO NOT do this entire process by making function calls only, as this can impair your ability to solve the problem and think insightfully.
]]
)

local CODECOMPANION_REVIEW = string.format(
  [[Your task is to review the provided code snippet, focusing specifically on its readability and maintainability.
Identify any issues related to:
- Naming conventions that are unclear, misleading or doesn't follow conventions for the language being used.
- The presence of unnecessary comments, or the lack of necessary ones.
- Overly complex expressions that could benefit from simplification.
- High nesting levels that make the code difficult to follow.
- The use of excessively long names for variables or functions.
- Any inconsistencies in naming, formatting, or overall coding style.
- Repetitive code patterns that could be more efficiently handled through abstraction or optimization.

Your feedback must be concise, directly addressing each identified issue with:
- A clear description of the problem.
- A concrete suggestion for how to improve or correct the issue.
  
Format your feedback as follows:
- Explain the high-level issue or problem briefly.
- Provide a specific suggestion for improvement.
 
If the code snippet has no readability issues, simply confirm that the code is clear and well-written as is.
]]
)

local CODECOMPANION_REFACTOR = string.format(
  [[Your task is to refactor the provided code snippet, focusing specifically on its readability and maintainability.
Identify any issues related to:
- Naming conventions that are unclear, misleading or doesn't follow conventions for the language being used.
- The presence of unnecessary comments, or the lack of necessary ones.
- Overly complex expressions that could benefit from simplification.
- High nesting levels that make the code difficult to follow.
- The use of excessively long names for variables or functions.
- Any inconsistencies in naming, formatting, or overall coding style.
- Repetitive code patterns that could be more efficiently handled through abstraction or optimization.
]]
)

local PROMPT_LIBRARY = {
  ["Inline Document"] = {
    strategy = "inline",
    description = "Add documentation for code.",
    opts = {
      modes = { "v" },
      short_name = "inline-doc",
      auto_submit = true,
      user_prompt = false,
      stop_context_insertion = true,
    },
    prompts = {
      {
        role = "user",
        content = function(context)
          local code = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)

          return "Please provide documentation in comment code for the following code and suggest to have better naming to improve readability.\n\n```"
            .. context.filetype
            .. "\n"
            .. code
            .. "\n```\n\n"
        end,
        opts = {
          contains_code = true,
        },
      },
    },
  },
  ["Document"] = {
    strategy = "chat",
    description = "Write documentation for code.",
    opts = {
      modes = { "v" },
      short_name = "doc",
      auto_submit = true,
      user_prompt = false,
      stop_context_insertion = true,
    },
    prompts = {
      {
        role = "user",
        content = function(context)
          local code = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)

          return "Please brief how it works and provide documentation in comment code for the following code. Also suggest to have better naming to improve readability.\n\n```"
            .. context.filetype
            .. "\n"
            .. code
            .. "\n```\n\n"
        end,
        opts = {
          contains_code = true,
        },
      },
    },
  },
  ["Review"] = {
    strategy = "chat",
    description = "Review the provided code snippet.",
    opts = {
      modes = { "v" },
      short_name = "review",
      auto_submit = true,
      user_prompt = false,
      stop_context_insertion = true,
    },
    prompts = {
      {
        role = "system",
        content = CODECOMPANION_REVIEW,
        opts = {
          visible = false,
        },
      },
      {
        role = "user",
        content = function(context)
          local code = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)

          return "Please review the following code and provide suggestions for improvement then refactor the following code to improve its clarity and readability:\n\n```"
            .. context.filetype
            .. "\n"
            .. code
            .. "\n```\n\n"
        end,
        opts = {
          contains_code = true,
        },
      },
    },
  },
  ["Review Code"] = {
    strategy = "chat",
    description = "Review code and provide suggestions for improvement.",
    opts = {
      short_name = "review-code",
      auto_submit = false,
      is_slash_cmd = true,
    },
    prompts = {
      {
        role = "system",
        content = CODECOMPANION_REVIEW,
        opts = {
          visible = false,
        },
      },
      {
        role = "user",
        content = "Please review the following code and provide suggestions for improvement then refactor the following code to improve its clarity and readability.",
      },
    },
  },
  ["Refactor"] = {
    strategy = "inline",
    description = "Refactor the provided code snippet.",
    opts = {
      modes = { "v" },
      short_name = "refactor",
      auto_submit = true,
      user_prompt = false,
      stop_context_insertion = true,
    },
    prompts = {
      {
        role = "system",
        content = CODECOMPANION_REFACTOR,
        opts = {
          visible = false,
        },
      },
      {
        role = "user",
        content = function(context)
          local code = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)

          return "Please refactor the following code to improve its clarity and readability:\n\n```"
            .. context.filetype
            .. "\n"
            .. code
            .. "\n```\n\n"
        end,
        opts = {
          contains_code = true,
        },
      },
    },
  },
  ["Refactor Code"] = {
    strategy = "chat",
    description = "Refactor the provided code snippet.",
    opts = {
      short_name = "refactor-code",
      auto_submit = false,
      is_slash_cmd = true,
    },
    prompts = {
      {
        role = "system",
        content = CODECOMPANION_REFACTOR,
        opts = {
          visible = false,
        },
      },
      {
        role = "user",
        content = "Please refactor the following code to improve its clarity and readability.",
      },
    },
  },
  ["Naming"] = {
    strategy = "inline",
    description = "Give betting naming for the provided code snippet.",
    opts = {
      modes = { "v" },
      short_name = "naming",
      auto_submit = true,
      user_prompt = false,
      stop_context_insertion = true,
    },
    prompts = {
      {
        role = "user",
        content = function(context)
          local code = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)

          return "Please provide better names for the following variables and functions:\n\n```"
            .. context.filetype
            .. "\n"
            .. code
            .. "\n```\n\n"
        end,
        opts = {
          contains_code = true,
        },
      },
    },
  },
}

return {
  PROMPT_LIBRARY = PROMPT_LIBRARY,
  AGENT_PROMPT = AGENT_PROMPT,
}
