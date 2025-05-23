# Ruta del directorio con archivos YAML
$yamlPath = "C:\repositorio\Dev_Project\deployment\NewServices"

# Namespace opcional (déjalo vacío si no deseas especificarlo)
$namespace = "default"

# Crear el namespace si no existe (opcional)
if ($namespace -ne "") {
    kubectl get namespace $namespace -ErrorAction SilentlyContinue | Out-Null
    if ($LASTEXITCODE -ne 0) {
        kubectl create namespace $namespace
    }
}

# Aplicar todos los archivos YAML del directorio
Get-ChildItem -Path $yamlPath -Recurse -Include *.yaml, *.yml | ForEach-Object {
    $file = $_.FullName
    if ($namespace -ne "") {
        kubectl delete -f $file -n $namespace
    } else {
        kubectl delete -f $file
    }
}
