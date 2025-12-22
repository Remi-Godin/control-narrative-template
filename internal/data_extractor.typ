#let doc_info = toml("../doc_info.toml")
#let title = doc_info.at("title")
#let document_type = doc_info.at("document_type")
#let operational_scope = doc_info.at("operational_scope")
#let system_scope = doc_info.at("system_scope")
#let iec_61355_type = doc_info.at("iec_61355_type")
#let doc_num = doc_info.at("doc_num")
#let creator = doc_info.at("creator")
#let approver = doc_info.at("approver")
#let owner = doc_info.at("owner")
#let issuing_dept = doc_info.at("issuing_dept")
#let metadata = json("../metadata.json")
#let revision = metadata.at("rev")
#let status = metadata.at("status")
#let issue_date = metadata.at("date")
#let hash = metadata.at("hash")

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

