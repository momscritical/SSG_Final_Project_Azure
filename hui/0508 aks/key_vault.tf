resource "azurerm_key_vault" "key_vault_1" {
  name                        = "${var.az_prefix}-key-vault-1"
  location                    = data.azurerm_resource_group.rg.location
  resource_group_name         = data.azurerm_resource_group.rg.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.client_config.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

}

resource "azurerm_key_vault_access_policy" "key_vault_access_policy" {
    key_vault_id = azurerm_key_vault.key_vault_1.id
    tenant_id    = data.azurerm_client_config.client_config.tenant_id
    object_id    = azurerm_user_assigned_identity.base.principal_id
    storage_permissions = [ "Get", "List", "Update", "Set"]
    key_permissions = [ "Get", "List" ]
    secret_permissions = [ "Get", "List" ]
    certificate_permissions = [ "Get", "List" ]
    depends_on = [ azurerm_key_vault.key_vault_1 ]
}

resource "azurerm_key_vault_certificate" "key_vault_cert" {
  name         = "${var.az_prefix}-cert"
  key_vault_id = azurerm_key_vault.key_vault_1.id

  certificate_policy {
    issuer_parameters {
      name = "Self"
    }

    key_properties {
      exportable = true
      key_size   = 2048
      key_type   = "RSA"
      reuse_key  = true
    }

    lifetime_action {
      action {
        action_type = "AutoRenew"
      }

      trigger {
        days_before_expiry = 30
      }
    }

    secret_properties {
      content_type = "application/x-pkcs12"
    }

    x509_certificate_properties {
      # Server Authentication = 1.3.6.1.5.5.7.3.1
      # Client Authentication = 1.3.6.1.5.5.7.3.2
      extended_key_usage = ["1.3.6.1.5.5.7.3.1"]

      key_usage = [
        "cRLSign",
        "dataEncipherment",
        "digitalSignature",
        "keyAgreement",
        "keyCertSign",
        "keyEncipherment",
      ]

    #   subject_alternative_names {
    #     dns_names = ["internal.contoso.com", "domain.hello.world"]
    #   }

      subject            = "${var.az_prefix}_key_vault_cert"
      validity_in_months = 12
    }
  }
}