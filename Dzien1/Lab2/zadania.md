#  Zadania z bieżącego oraz kolejnych laboratoriów wykonuj w folderze/konfiguracji Terraform z Lab1 Zadanie2

## Zadanie 1 - Storage Account

Celem tego zadania jest nauczenie się importowania zasobów do stanu.

W ramach tego zadania należy utworzyć zasób Storage Account ręcznie w Azure, przygotować kod Terraform reprezentujący
dany zasób i zaimportować zasób do stanu przy pomocy polecenia `terraform import`.

Aby zrealizować to zadanie, należy wykonać następujące kroki:

1. Utwórz zasób Storage Account w portalu Azure. Użyj tego samego regionu, w którym znajduje się Twoja grupa zasobów.
2. Przygotuj reprezentacje storage account w nowym pliku Terraform nazwanym `storage.tf`.
3. Zaimportuj utworzony zasób przy pomocy polecenia `terraform import`.
4. Sprawdź zmiany w pliku stanu po zaimportowaniu zasobu.
5. Uruchom polecenie `terraform plan` w celu sprawdzenia zgodności opisanego zasobu ze znajdującym się w chmurze.

Pomoce linki:
* [Zasób azurerm_storage_account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account)
* [Polecenie terraform import](https://developer.hashicorp.com/terraform/cli/commands/import)


## Zadanie 2 - Key Vault

Celem tego zadania jest nauczenie się tworzenia zasobów w chmurze Azure przy użyciu Terraform.

W ramach tego zadania należy dodać do konfiguracji z zadania poprzedniego tworzenie nowego zasobu Azure Key Vault w pobranej
przy pomocy Data grupie zasobów. Podczas konfiguracji zasobu Azure Key Vault nadaj uprawnienia swojemu użytkownikowi do 
pobierania i tworzenia sekretów.

Aby zrealizować to zadanie, należy wykonać następujące kroki:

1. Do pliku `data.tf` dodaj nowy blok data typu `azurerm_client_config`. Zawiera on informacje na temat aktualnie
   skonfigurowanego klienta w providerze. W naszym przypadku będzie to aktualnie zalogowany użytkownik.
2. W nowo utworzonym pliku `keyvault.tf`skonfiguruj blok zasobu dla usługi Azure Key Vault. Podczas
   konfigurowania zasobu wykorzystaj w odpowiednich parametrach referencje do pobieranej grupy zasobów. W
   bloku `access_policy` skonfiguruj uprawnienia dla swojego użytkownika.
   * Podczas tworzenia zasobu wybierz sku: Standard
   * Wartości object_id oraz tenant_id dla swojego użytkownika może pobrać z portalu lub wykorzystując data
   source `azurerm_client_config`.
3. Uruchom polecenie `terraform plan`. Sprawdź, czy Terraform wykrył błędy w konfiguracji. Zwróć uwagę na wynik planu,
   Terraform powinien zwrócić, że utworzy jeden nowy zasób.
4. Uruchom polecenie `terraform apply`, aby wdrożyć zasób Azure Key Vault.
5. Zweryfikuj, czy utworzenie zasobu przebiegło pomyślnie przez wyszukanie zasobu w portalu Azure.
6. Sprawdź, jakie zmiany powstały w pliku stanu, zwróć uwagę na różnice pomiędzy `data` a `resource`.

Pomocne linki:

* [Zasób azurerm_key_vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault)
* [Data azurerm_client_config](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config)


## Zadanie 3 - Virtual Network Shared

Celem tego zadania jest nauczenie się korzystania ze zmiennych.

W ramach tego zadania należy stworzyć sieć wirtualną `vnet-shared` oraz podsieć `endpoints` przy pomocy zasobów 
`azurerm_virtual_network` oraz `azurerm_subnet`. Nazwy zasobów i zakresy sieciowe sieci/podsieci umieść w zmiennych.
Wykorzystaj zmienną lokalną do wymuszenia prefixu w nazwach zasobów z Twoim numerem studenta.
Zasoby umieść w przygotowanej dla Ciebie grupie zasobów.

Aby zrealizować to zadanie, należy wykonać następujące kroki:

1. Utwórz plik `variables.tf` i zdefiniuj w nim zmienne: `vnet_name`, `subnet_name`, `vnet_address_space` i `subnet_address_prefixes`.
2. Dodaj do pliku `variables.tf` zmienną lokalną `prefix`, która będzie zawierać Twój numer kursanta. Wykorzystasz go jako prefix dodawany
   na początku lub końcu nazw tworzonych zasobów.*
3. Utwórz plik `network.tf` i dodaj do niego zasoby `azurerm_virtual_network` i `azurerm_subnet`, skonfiguruj je z wykorzystaniem zmiennych i zmiennych lokalnych.
4. Utwórz plik `terraform.tfvars` i przypisz wartości do zmiennej.
5. Uruchom polecenie `terraform plan`. Sprawdź, czy Terraform wykrył błędy w konfiguracji.
6. Uruchom polecenie `terraform apply`, aby powołać nowe zasoby.
7. Spróbuj przekazać wartość zmiennej do konfiguracji Terraform na inne sposoby np. z poziomu opcji CLI -var, zmiennych
   środowiskowych TF_VAR_. Spróbuj przekazać wartość na kilka sposób jednocześnie i sprawdź efekt.*


Pomocne linki:

* [Zasób azurerm_virtual_network](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network)
* [Zasób azurerm_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet)
* [Zmienne w terraform](https://developer.hashicorp.com/terraform/language/values/variables)
* [Pierwszeństwo definicji zmiennych](https://developer.hashicorp.com/terraform/language/values/variables#variable-definition-precedence)


## Zadanie 4 - File Share (Zadanie opcjonalne)

Do utworzonego wcześniej Azure Storage Account nalezy zdefiniować utworzenie Azure Storage File Share.
Azure Storage File Share zostanie podłączony do naszej aplikacji w celu przechowywania plików.

Na co warto zwrócić uwagę:

* Wykorzystaj istniejący plik `storage.tf` lub stwórz nowy, dedykowany dla zasobu File Share.
* Podczas tworzenia File Share wybierz Quota: 50gb.
* Zasób ten będzie dedykowany dla środowiska aplikacji.

Pomocne linki:

* [Dokumentacja Storage Account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account)
* [Dokumentacja Storage Share](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_share)

## Zadanie 5 - Container Registry

W ramach tego zadania należy utworzyć Azure Container Registry, w którym przechowywane będą obrazy aplikacji.

Na co warto zwrócić uwagę:

* Stwórz nowy plik i nazwyj go np. `acr.tf`.
* ACR będzie współdzielony pomiędzy środowiskami, dlatego w kolejnych zadaniach będzie umieszczony w sieci Shared,
* Podczas tworzenia zasobu wybierz sku: `Premium`, tylko w tym planie jest dostępna możliwość komunikacji prywatnej.
* Stwórz zasób z włączoną opcją użytkownika typu administrator definiując odpowiedni argument wraz z wartością.
* Zablokuj dostep publiczny do tworzonej usługi definiując odpowiedni argument wraz z wartością.

Pomocne linki:

* [Dokumentacja zasobu azurerm_container_registry](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry)

## Zadanie 6 - DNS Zone/Private Endpoint

W tym zadaniu utworzymy private endpoint dla Azure Container Registry, tak aby usługa wykorzystywała do komunikacji sieć prywatną.

Przed przystąpieniem do utworzenia private endpoint, należy utworzyć prywatną strefę DNS oraz powiązać ją z siecią wirtualną.
Nazwę strefy DNS przekaż w formie zmiennej lokalnej. Użyj zmiennej, w postaci mapy `map(string)`, w której kluczem będzie skrócona nazwa usługi,
a wartością nazwa strefy DNS.
Prywatne strefy DNS wykorzystywane przez private endpoint powinny korzystać z zalecanych nazw.

Przykład zmiennej lokalnej typu `map(string)`:

```terraform
locals {
  zones = {
    "file"       = "privatelink.file.core.windows.net"
    "postgresql" = "privatelink.postgres.database.azure.com"
  }
}
```

Na co warto zwrócić uwagę:

* Dla przejrzystości kodu, utwórz nowe dedykowane pliki np. `dns.tf` oraz `endpoints.tf`.
* W bloku `private_service_connection` podczas tworzenia private endpoint, należy wskazać id zasobu, dla którego
  tworzymy endpoint oraz nazwę zasobu podrzędnego. Wyszukaj jej wartość w dokumentacji.
* W bloku `private_dns_zone_group` podczas tworzenia private endpoint należy wskazać id prywatnej strefy dns, dzięki temu
  odpowiedni rekord A wskazujący na interfejs sieciowy endpointu zostanie automatycznie dodany.
* W parametrze `subnet_id` podczas tworzenia private endpoint należy wskazać podsieć przeznaczoną na private endpoint.
   będzie to podsieć `endpoints`w sieci `vnet-shared`.

Pomocne linki:

* [Zalecane nazwy prywatnych stref dns](https://learn.microsoft.com/pl-pl/azure/private-link/private-endpoint-dns#azure-services-dns-zone-configuration)
* [Dostępne nazwy zasobów podrzędnych](https://learn.microsoft.com/en-gb/azure/private-link/private-endpoint-overview#private-link-resource)
* [Dokumentacja zasobu private_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint)
* [Dokumentacja zasobu private_dns_zone](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone)
* [Dokumentacja zasobu private_dns_zone_virtual_network_link](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link)