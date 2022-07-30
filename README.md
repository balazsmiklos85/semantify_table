# semantify_table
A script that converts Markdown tables to something more semantically appropriate

## Use case

I have some old documentation in Markdown format that has tables like 

| **Name** | **Default value** | **Description**                 |
|----------|-------------------|---------------------------------|
| foo      | 1                 | This thing does something.      |
| bar      | `{}`              | This thing does something else. |

which are not really tables. They should look more like

```markdown
# foo

Default value: 1

This thing does something.

# bar

Default value: `{}`

This thing does something else.
```

## Usage

* Clone the project
* `cd semantify_table`
* `ruby lib/semantify_table.rb source_file.md [target_file.md]`

If the target file is not specified, then the source file will be overwritten.