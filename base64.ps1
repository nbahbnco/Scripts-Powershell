$bytes = [System.IO.File]::ReadAllBytes("deflate.zip")

$BASE64=[System.Convert]::ToBase64String($bytes)

$ENCODED1 = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($ficheroZip))


$ENCODED1 | Expand-Archive