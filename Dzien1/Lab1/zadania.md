# Szkolenie Terraform: Dzień 1

## Zadanie 1 - Provider

Celem tego zadania laboratoryjnego jest nauczenie się konfigurowania providera AzureRM oraz pobierania istniejących
zasobów przy pomocy bloku data w chmurze Azure.

W ramach zadania należy skonfigurować providera AzureRM oraz pobrać istniejącą grupę zasobów według przekazanych dostępów.

Aby zrealizować to zadanie, należy wykonać następujące kroki:

1. Zaloguj się do przypisanego do Ciebie konta Azure przy pomocy komendy `az login` w konsoli na swojej stacji.
2. Przygotuj folder dla swoich plików Terraform. W nim utwórz plik `providers.tf` i skonfiguruj w nim providera AzureRM. Zwróć uwagę, aby w konfiguracji providera wskazać odpowiednie ID Subskrypcji, na której będzie znajdować się pobierana grupa zasobów. Wskaż użycie konkretnej wersji
   providera: `3.40.0`.
3. Wykonaj inicjalizację konfiguracji przy pomocy komendy `terraform init`.
4. Utwórz plik `data.tf` i dodaj w nim blok data typu `azurerm_resource_group`. Skonfiguruj go zgodnie z dokumentacją,
   tak aby pobrać wymaganą grupę zasobów.
5. Uruchom polecenie `terraform plan`, aby sprawdzić, czy Terraform wykrył grupę zasobów i czy nie ma błędów w
   konfiguracji.
6. Uruchom polecenie `terraform apply`. Terraform pobierze istniejącą grupę zasobów z Azure, zapisze ją w stanie i
   zakończy działanie bez wprowadzania żadnych zmian.
7. Sprawdź, co zostało zapisane w pliku stanu po uruchomieniu polecenia `terraform apply`.

Pomocne linki:

* [Dokumentacja providera AzureRM](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
* [Data azurerm_resource_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group)


## Zadanie 2 - Remote Backend

Celem tego zadania jest nauka konfiguracji backend'u tak aby przechowywać i zarządzać plikiem stanu zdalnie.

W tym celu wykorzystamy usługę Storage Account, w której będziemy przechowywać stan naszej infrastruktury chmurowej.
Pamiętaj, że nazwa instancji Storage Account **musi być unikalna globalnie.**

Aby zrealizować to zadanie, należy wykonać następujące kroki:

1. Otwórz portal Azure. Upewnij się, że jesteś zalogowany do tenant'a wykorzystywanego w trakcie bieżącego kursu i 
   widzisz swoją grupę zasobów.
2. Stwórz ręcznie Storage Account w swojej grupie zasobów, wykorzystaj ustawienia domyślne.
3. Nadaj swojemu użytkownikowi rolę Storage Blob Data Owner na poziomie utworzonego Storage.
4. W nowo utworzonym storage'u stwórz kontener o nazwie `tfstate`.
5. W folderze z Twoją konfiguracją Terraform, utwórz nowy folder i skopiuj do niego pliki `.tf` z kodem z poprzedniego zadania.
6. Utwórz nowy plik `backend.tf` i skonfiguruj blok backend `azurerm` wskazujac nowy kontener. Na potrzeby naszego
   laboratorium wykorzystaj metodę autentykacji do storage'a poprzez Twoje konto Azure AD.
7. Przejdź do nowego katalogu i wykonaj inicjalizację konfiguracji przy pomocy komendy `terraform init`.
8. Uruchom polecenie `terraform plan` aby sprawdzić, czy Terraform wykrył grupę zasobów i czy nie ma błędów w konfiguracji.
9. Uruchom polecenie `terraform apply`. Terraform pobierze istniejącą grupę zasobów z Azure, zapisze ją w stanie i
   zakończy działanie bez wprowadzania żadnych zmian.
10. Sprawdź, co zostało zapisane w zdalnym pliku stanu (w kontenerze) po uruchomieniu polecenia `terraform apply`.

Pomocne linki:

* [Dokumentacja backend azurerm](https://developer.hashicorp.com/terraform/language/settings/backends/azurerm)
