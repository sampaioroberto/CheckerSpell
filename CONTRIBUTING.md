## 🚀 Branch Naming Convention

To keep our repository organized and make it easier to track work, we follow this branch naming pattern:

```
<type>/<issue-number>-<short-description>
```

### 🔹 Types:
| Type      | Description                                      |
|-----------|--------------------------------------------------|
| feature   | For new features or enhancements                |
| fix       | For bug fixes                                    |
| chore     | For maintenance tasks (configs, updates, etc.)  |
| refactor  | For code improvements without functional changes |
| test      | For adding or updating tests                    |
| docs      | For documentation updates                       |

### 🔹 Examples:
| Purpose                                  | Branch name                    |
|-------------------------------------------|---------------------------------|
| Create the Play Screen (Issue #12)       | `feature/12-play-screen`       |
| Fix piece selection logic (Issue #15)    | `fix/15-piece-selection`       |
| Refactor board performance (Issue #22)   | `refactor/22-board-optimization`|
| Update README (Issue #30)                | `docs/30-update-readme`        |
| Add move tests (Issue #18)               | `test/18-move-tests`           |

### 🔹 Tips:
- Use **kebab-case** (lowercase with hyphens) for the description.
- Keep the description short and meaningful.
- Always include the **issue number** to link the branch to the related task.
- Mention the issue in your Pull Request description using keywords like `Closes #12` to automatically close the issue when merging.

---

## 📝 Commit Message Guidelines

To keep a clear and meaningful commit history, follow this pattern:

```
<type>: <short-description>

<optional detailed description>

Refs: #<issue-number>
```

### 🔹 Commit Types:
- feat: A new feature
- fix: A bug fix
- chore: Maintenance tasks
- refactor: Code improvements
- test: Adding or updating tests
- docs: Documentation updates

### 🔹 Example:
```
feat: add piece selection logic

Implemented selection logic for pieces on the Play Screen with visual feedback.

Refs: #12
```

---

## 🚀 Pull Request Guidelines

When creating a Pull Request:
- Use a clear and descriptive title.
- Reference the related issue using keywords like `Closes #<issue-number>`.
- Provide a brief summary of the changes.
- Include any relevant screenshots or videos if applicable.
- Ensure all checks pass before requesting a review.

### 🔹 Example PR Description:
```
### Summary
Added piece selection logic to the Play Screen.

### Changes
- Implemented single piece selection.
- Added visual feedback for selected pieces.

Closes #12
```

