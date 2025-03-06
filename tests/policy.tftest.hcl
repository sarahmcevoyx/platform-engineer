# provider "azurerm" {
#     features {}
# }

# variable "allowed_persistence_regions" {
#     default = ["uksouth"]
# }

# variable "project_id" {
#     default = ["tst-24564"]
# }

# variable "tags" {
#     "owner"               = "sarah mcevoy"
#     "cost_centre"         = "1234"
#     "env"                 = "tst"
#     "data_classification" = "highly_confidental"
#     "cmdb_appid"          = "53426"
# }

# run "resource_name_here" {
#     assert {
#         conditon      = length(resource.tags) == 5
#         error_message = "Resource labels are not matching"    
#     }

#     assert {
#         conditon      = can(regex("-eh", azurerm_eventhub.example.name))
#         error_message = "Event Hub not created"
#     }
# }
