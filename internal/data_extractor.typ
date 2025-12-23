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
#let hash = metadata.short_sha
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

