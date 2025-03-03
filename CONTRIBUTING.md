## 🚀 Branch Naming Convention

To keep our repository organized and make it easier to track work, we follow this branch naming pattern:

```
<type>/<issue-number>-<short-description>
```

### 🔹 Types:
| Type      | Description                                      |
|-----------|--------------------------------------------------|
| feature   | For new features or enhancements                 |
| fix       | For bug fixes                                    |
| refactor  | For code improvements without functional changes |
| test      | For adding or updating tests                     |
| docs      | For documentation updates                        |

### 🔹 Examples:
| Purpose                                  | Branch name                      |
|------------------------------------------|----------------------------------|
| Create the Play Screen (Issue #12)       | `feature/12-play-screen`         |
| Fix piece selection logic (Issue #15)    | `fix/15-piece-selection`         |
| Refactor board performance (Issue #22)   | `refactor/22-board-optimization` |
| Update README (Issue #30)                | `docs/30-update-readme`          |
| Add move tests (Issue #18)               | `test/18-move-tests`             |

### 🔹 Tips:
- Use **kebab-case** (lowercase with hyphens) for the description.
- Keep the description short and meaningful.
- Always include the **issue number** to link the branch to the related task.
- Mention the issue in your Pull Request description using keywords like `Closes #12` to automatically close the issue when merging.

---

## 📝 Commit Message Guidelines

There's no guideline for commit, since we will squash them when merging the Pull Requests.

---

## 🚀 Pull Request Guidelines

When creating a Pull Request:
- Title should be in the format `[#<type>-#<issue-number>] Descriptive Title`.
- Provide a brief summary of the changes.
- Reference the related issue using keywords like `Closes #<issue-number>`.
- Include any relevant screenshots or videos if applicable.
- Read the summary from Sourcery and adjust (merge the summaries)

### 🔹 Types:
| Type      | Description                                      |
|-----------|--------------------------------------------------|
| FR        | For new features or enhancements                 |
| FIX       | For bug fixes                                    |
| REF       | For code improvements without functional changes |
| TEST      | For adding or updating tests                     |
| DOC       | For documentation updates                        |

### 🔹 Example PR Description:
```
## Title: [FR-1] Add Play Screen and selection logic
### Summary
Added piece selection logic to the Play Screen.

Closes #12
```

