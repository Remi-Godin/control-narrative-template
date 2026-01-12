// Document info
#let doc_info = toml("../doc_info.toml")
#let title = doc_info.title
#let document_type = doc_info.document_type
#let operational_scope = doc_info.operational_scope
#let system_scope = doc_info.system_scope
#let iec_61355_type = doc_info.iec_61355_type
#let doc_num = doc_info.doc_num
#let creator = doc_info.creator
#let approver = doc_info.approver
#let owner = doc_info.owner
#let issuing_dept = doc_info.issuing_dept
#let scopes = if doc_info.keys().contains("scope") {
  doc_info.scope
} else {
  none
}
#let products = if doc_info.keys().contains("product") {
  doc_info.product
} else {
  none
}

// Metadata
#let metadata = json("../metadata.json")
#let status = metadata.status
#let issue_date = metadata.date
#let hash = upper(metadata.short_sha)
#let changes = metadata.commits_since_tag
#let revision = {
  if status == "DRAFT" {
    metadata.formal_rev + "(+" + changes + ")"
  } else {
    metadata.formal_rev
  }
}

#let full_id = (
  "=="
    + operational_scope
    + if type(system_scope) == array {
      for i in system_scope { "=" + i }
    } else {
      "=" + system_scope
    }
    + "&"
    + iec_61355_type
    + "-"
    + doc_num
)


#let params = toml("../params.toml")
#let param(num) = {
  if params.param.keys().contains(str(num)) {
    let param_type = if params.param.at(str(num)).keys().contains("type") {
      params.param.at(str(num)).type
    } else {
      none
    }
    let prefix = if param_type != none {
      ":" + str(param_type)
    } else { "" }

    (
      text(
        weight: "bold",
        font: "Noto Sans Mono",
        fill: purple,
        "[P" + str(num) + prefix + "]",
      )
        + text(
          font: "Noto Sans Mono",
          fill: purple,
          params.param.at(str(num)).name,
        )
    )
  } else {
    text(fill: red, "PARAM " + str(num) + " DOES NOT EXIST")
  }
}
#let render-param-table(params, start: none, stop: none) = {
  // 1. Filter and sort the parameters first
  let filtered-params = params
    .param
    .pairs()
    .map(it => (int(it.at(0)), it.at(1))) // Convert ID string to integer
    .filter(it => {
      let id = it.at(0)
      let after-start = (start == none or id >= start)
      let before-stop = (stop == none or id <= stop)
      after-start and before-stop
    })
    .sorted(key: it => it.at(0))

  // 2. Render the table
  table(
    columns: (auto, 1fr, auto),
    align: horizon,
    [*ID*], [*Parameter Name*], [*Type*],

    ..for (id, info) in filtered-params {
      (
        "P" + str(id),
        raw(info.name),
        if info.keys().contains("type") { info.type } else { none },
      )
    },
  )
}


#let commands = toml("../commands.toml")
#let command(num) = {
  if commands.command.keys().contains(str(num)) {
    let command_type = if commands
      .command
      .at(str(num))
      .keys()
      .contains("type") {
      commands.command.at(str(num)).type
    } else {
      none
    }
    let prefix = if command_type != none {
      ":" + str(command_type)
    } else { "" }

    (
      text(
        weight: "bold",
        font: "Noto Sans Mono",
        fill: orange,
        "[C" + str(num) + prefix + "]",
      )
        + text(
          font: "Noto Sans Mono",
          fill: orange,
          commands.command.at(str(num)).name,
        )
    )
  } else {
    text(fill: red, "COMMAND" + str(num) + " DOES NOT EXIST")
  }
}
#let render-command-table(commands, start: none, stop: none) = {
  // 1. Filter and sort the commandeters first
  let filtered-commands = commands
    .command
    .pairs()
    .map(it => (int(it.at(0)), it.at(1))) // Convert ID string to integer
    .filter(it => {
      let id = it.at(0)
      let after-start = (start == none or id >= start)
      let before-stop = (stop == none or id <= stop)
      after-start and before-stop
    })
    .sorted(key: it => it.at(0))

  // 2. Render the table
  table(
    columns: (auto, 1fr, auto),
    align: horizon,
    [*ID*], [*Command Name*], [*Type*],

    ..for (id, info) in filtered-commands {
      (
        "C" + str(id),
        raw(info.name),
        if info.keys().contains("type") { info.type } else { none },
      )
    },
  )
}
