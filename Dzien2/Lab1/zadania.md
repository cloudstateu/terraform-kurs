## Zadanie 1 - DNS Zones

Celem tego zadania jest nauczenie się wykorzystywania pętli `for_each`.

W ramach tego zadania należy utworzyć zmienną lokalną o nazwie `zones`, lub skorzystać z tej utworzonej w zadaniu 6 z dnia 1.
Zmienna powinna mieć typ `map(string)` i zawierać prywatne strefy DNS dla następujących usług: Azure File Share, 
Azure Container Registry, Azure Key Vault, Azure Kubernetes Service, Azure Database for PostgreSQL.
Następnie przy pomocy pętli `for_each` należy utworzyć prywatne strefy DNS oraz ich połączenie z siecią `vnet-shared`.
Prywatne strefy DNS wykorzystywane przez private endpoint powinny korzystać z zalecanych nazw.
Nazwy połączeń powinny zawierać nazwę strefy lub jej klucz w zmiennej lokalnej oraz nazwę sieci do której tworzone jest połączenie.

Przykład zmiennej lokalnej typu `map(string)`:

```terraform
locals {
  zones = {
    "file"       = "privatelink.file.core.windows.net"
    "postgresql" = "privatelink.postgres.database.azure.com"
  }
}
```

Aby zrealizować to zadanie, należy wykonać następujące kroki:

1. Wykorzystaj plik Terraform, w którym zdefiniowałeś tworzenie prywatnych stref DNS w poprzednich zadaniach. Zmodyfikujemy go
   na potrzeby zadania bieżącego.
2. Użyj zmiennej lokalnej o nazwie `zones` typu `map(string)`, w której dodasz nazwy tworzonych stref DNS. Niech klucze będą 
   skrótami usług, dla których tworzone są strefy, a wartości przyjmują nazwy poszczególnych stref.
3. Zmodyfikuj zasób typu `private_dns_zone`. Podczas konfiguracji wykorzystaj pętlę `for_each`. Nazwa strefy powinna być 
   przykazywana jako wartość zmiennej lokalnej, po której będzie iterować Terraform.
4. Zmiany będą wymagały dostosowania utworzonego wcześniej Private Endpoint dla usługi Azure Container Registry, tak aby
   korzystała ona z zasobu prywatnej strefy DNS tworzonej z użyciem pętli.
5. Uruchom polecenie `terraform plan`. Sprawdź, czy Terraform wykrył błędy w konfiguracji.
6. Uruchom polecenie `terraform apply`, aby utworzyć zasoby.
7. Zweryfikuj, czy utworzenie zasobów przebiegło pomyślnie.
8. Sprawdź jak przedstawiony jest zasób wykorzystujący `for_each` w pliku stanu. (Dla chętnych)
9. Dodaj zasób łączący strefy DNS z siecią `vnet-shared`. Również wykorzystaj pętlę `for_each`. Dodatkowo w nazwie zasobu
   połącz myślnikiem nazwę usługi, przetrzymywaną jako klucz w zmiennej lokalnej, z nazwą sieci np. `file-vnet-shared`.

Pomocne linki:

* [Zalecane nazwy prywatnych stref dns](https://learn.microsoft.com/pl-pl/azure/private-link/private-endpoint-dns#azure-services-dns-zone-configuration)
* [Pętla for_each](https://developer.hashicorp.com/terraform/language/meta-arguments/for_each)
* [Dokumentacja zasobu private_dns_zone](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone)
* [Dokumentacja zasobu private_dns_zone_virtual_network_link](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link)

## Zadanie 2 - Key Vault Secrets (Zadanie opcjonalne)

Celem tego zadania jest nauczenie się wykorzystania pętli count.

W ramach tego zadania należy utworzyć nową zmienną lokalną `passwords` typu `list(string)`.
Dodaj do listy co najmniej dwa przykładowe hasła.
Następnie przy pomocy `azurerm_key_vault_secret` i `count` utworzyć sekrety w Azure Key Vault.

Przykład zmiennej lokalnej typu `list(string)`:

```terraform
locals {
  passwords = [
    "secretvalue123",
    "secretvalue321"
  ]
}
```

Aby zrealizować to zadanie, należy wykonać następujące kroki:

1. W pliku `keyvault.tf` utwórz nową zmienną lokalną o nazwie `passwords`.
2. Dodaj nowy zasób typu `azurerm_key_vault_secret`. Podczas konfiguracji wykorzystaj pętlę`count` i zadbaj o unikalność 
   nazw tworzonych sekretów. Wartość sekretu pobierz ze zmiennej lokalnej. Pamiętaj, że przy wykorzystaniu `count` masz
   dostęp do słowa kluczowego `count` przy pomocy którego możesz odwołać się konkretnej iteracji np. `count.index`.
3. Uruchom polecenie `terraform plan`. Sprawdź, czy Terraform wykrył błędy w konfiguracji.
4. Uruchom polecenie `terraform apply`, aby utworzyć sekret.
5. Zweryfikuj, czy utworzenie sekretu przebiegło pomyślnie przez jego wyszukanie w Azure Key Vault.
6. Dodaj kolejne hasła do zmiennej lokalnej np. na początku listy, na końcu i na środku. Uruchom ponownie
   polecenie `terraform plan` i sprawdź, jak zachowa się Terraform wobec aktualnie istniejących sekretów.
7. Sprawdź jak przedstawiony jest zasób wykorzystujący `count` w pliku stanu.

Pomocne linki:

* [Zasób azurerm_key_vault_secret](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret)
* [Pętla count](https://developer.hashicorp.com/terraform/language/meta-arguments/count)


## Zadanie: 3 - Log Analytics Workspace (Zadanie opcjonalne)

Celem tego zadania jest nauczenie się wykorzystywania dynamic blocks.

W ramach tego zadania należy utworzyć zasób Log Analytics Workspace oraz skonfigurować przesyłanie do niego logów i metryk
z usługi Azure Key Vault. W tym celu należy wykorzystać zasób `azurerm_monitor_diagnostic_setting` oraz pobrać dostępne 
kategorie z wykorzystaniem bloku data `azurerm_monitor_diagnostic_categories`. Następnie udynamicznić bloki `enabled_log`
oraz `metric` wykorzystując funkcjonalność dynamic block oraz pętlę for_each.

Aby zrealizować to zadanie, należy wykonać następujące kroki:
1. Utwórz nowy plik np. `monitoring.tf` i zdefiniuj w nim tworzenie zasobu Log Analytics: `azurerm_log_analytics_workspace`.
2. Stwórz blok data typu `azurerm_monitor_diagnostic_categories` wskazując w argumencie `resource_id` ID Twojego Key Vault'a.
   Dzięki temu będziesz mógł pobrać wszystkie dostępne do śledzenia katerogie logów i metryk dla zasobu Azure Key Vault.
3. Zdefiniuj zasób `azurerm_monitor_diagnostic_setting`, w którym wskażesz wysyłanie logów z wybranego Azure Key Vault do
   zdefiniowanego w pierwszym kroku Log Analytics Workspace.
4. Wewnątrz zasobu Diagnostic Settings stwórz dynamiczne bloki `enabled_log` oraz `metric`. Za pomocą pętli `for_each`
   iteruj po odpowiednio kategoriach logów (atrybut `log_category_types`) i metrykach (atrybut `metrics`) dostępnych dzięki 
   pobranym w poprzednim pukncie zasobie Diagnostic Categories. W ten sposób definiujesz wysyłanie wszystkich dostepnych kategorii 
   logów i metryk do wskazanego Log Analytics Workspace.
5. Standardowo uruchom polecenia `terraform plan` aby zweryfikować swoją konifgurację oraz `terraform apply` aby wdrożyć zmiany.
6. Zweryfikuj utworzenie Diagnostic Setting przez wyszukanie w Azure Key Vault.

Pomocne linki:

* [Dokumentacja Dynamic Blocks](https://developer.hashicorp.com/terraform/language/expressions/dynamic-blocks)
* [Dokumentacja Log Analytics Workspace](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace)
* [Dokumentacja Monitor Diagnostics Categories](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_diagnostic_categories)
* [Dokumentacja Diagnostic Setting](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting)
