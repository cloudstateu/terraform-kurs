<img src="./img/logo.png" alt="Chmurowisko logo" width="200" align="right">
<br><br>
<br><br>
<br><br>

# ZAD 1: Container Registry and Docker Image

1. Pobierz na maszynę Jumphost repozytorium publiczne z warsztatów - https://github.com/cloudstateu/terraform-kurs:
1. Zainstaluj Docker na maszynie Jumphost

    ```bash
    sudo apt install docker.io
    ```
1. Zainstaluj narzędzia - AZ Cli oraz Kubectl 
- Kubectl - https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/
- Az CLI - https://learn.microsoft.com/en-us/cli/azure/install-azure-cli-linux?pivots=apt

1. Przejdź do katalogu pobranego repozytorium GIT

    ```bash
    terraform-kurs/Dzien2/Lab2/docker/app
    ```

1. Zaloguj się do repozytorium ACR

    ```bash
    docker login XXX.azurecr.io
    ```
    
    `XXX` to nazwa Twojej instancji Azure Container Registry.
    
1. Zbuduj obraz Docker

    ```bash
    docker build -t cm-acr-app .
    ```
    
1. Oznaczenie lokalnego obrazu

    ```bash
    docker image tag cm-acr-app:latest XXX.azurecr.io/cm-acr-app:latest
    ```
    
    `XXX` to nazwa Twojej instancji Azure Container Registry.
    
1. Wypchnięcie obrazu do instancji ACR

    ```bash
    docker push XXX.azurecr.io/cm-acr-app:latest 
    ```
    
    `XXX` to nazwa Twojej instancji Azure Container Registry.

## ZAD 2: Utwórz sekret Kubernetes z poświadczeniami ACR

1. Zaloguj się do Az CLI na swoje konto:

    ```bash
   az login
    ```
    

1. Uzyskaj poświadczenia dostępu dla swojego klastra Kubernetes.

    ```bash
   az aks get-credentials --resource-group XXX --name YYY
    ```
    `XXX` to nazwa Twojej Resource Group. `YYY` to nazwa Twojej instancji AKS

3. Utwórz Kubernetes Secret za pomocą poniższego polecenia. Upewnij się, że podałeś dane uwierzytelniające dla swojego ACR

    ```bash
    kubectl create secret docker-registry dockerregistrycredential --docker-server=<ACR_name>.azurecr.io --docker-username=<ACR_name> --docker-password=<password>
    ```

1. Sprawdź, czy sekret został utworzony

    ```bash
    kubectl get secret
    ```

## ZAD 3: Utwórz Deployment i Service na Kubernetes

1. Otwórz plik [files/cm-acr-app.yaml](./files/cm-acr-app.yaml) i sprawdź jego zawartość
1. Zaktualizuj sekcję `.spec.template`:

    ```yaml
    template:
      metadata:
        labels:
          app: cm-acr-app
      spec:
        containers:
        - name: app
          image: <ACR_name>.azurecr.io/<ACR_Image_Name> # update <ACR_name> and <ACR_Image_Name>
          ports:
          - containerPort: 8080
        imagePullSecrets:
        - name: dockerregistrycredential
    ```

1. Zastosuj zaktualizowany plik do Kubernetes:

    ```bash
    kubectl apply -f cm-acr-app.yaml
    ```

1. Zweryfikuj czy wszystkie POD'y zostaly poprawnie uruchomione:

    ```bash
    kubectl get pods
    ```
    Jeśli widzisz status `Running` to prawdopodobnie wszystko dziala poprawnie, przejdz do kolejnego kroku. 
    Jeśli widzisz inny status możesz wykonać prosty debug w ten sposób: 
   
    ```bash
    kubectl describe pods XXXXXX
    ```
    Gdzie `XXXXXX` to nazwa POD, który możesz podejrzeć z komendy `kubectl get pods`

3. Uzyskaj IP dla serwisu i przejdź do niego w przeglądarce.

    ```bash
    kubectl get svc
    ```

## END LAB

<br><br>

<center><p>&copy; 2023 Chmurowisko Sp. z o.o.<p></center>
